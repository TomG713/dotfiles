#!/bin/bash
##############################################################################
# yubikey-ssh-setup
# -----------
# Generates a new ssh key for a yubikey smartcard using GPG.
#
# Usage:
#       yubikey-ssh-setup
#
# :authors: Jess Frazelle, @jessfraz
# :date: 14 February 2018
# :version: 0.0.1
##############################################################################
set -e
set -o pipefail

SUBKEY_LENGTH=${SUBKEY_LENGTH:=4096}
SUBKEY_EXPIRE=${SUBKEY_EXPIRE:=0}
SURNAME=${SURNAME:="Gamble"}
GIVENNAME=${GIVENNAME:="Thomas"}
EMAIL=${EMAIL:=$GMAIL}
PUBLIC_KEY_URL=${PUBLIC_KEY_URL:="https://keybase.io/gambtho/key.asc"}
KEYID=${KEYID:=$GPGKEY}
SEX=${SEX:=F}

if [[ -z "$KEYID" ]]; then
	echo "Set the KEYID env variable."
	exit 1
fi

if [[ -z "$EMAIL" ]]; then
	echo "Set the EMAIL env variable."
	exit 1
fi

restart_agent(){
	# Restart the gpg agent.
	# shellcheck disable=SC2046
	kill -9 $(pidof scdaemon) >/dev/null 2>&1
	# shellcheck disable=SC2046
	kill -9 $(pidof gpg-agent) >/dev/null 2>&1
	gpg-connect-agent /bye >/dev/null 2>&1
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
}

setup_gnupghome(){
	# Create a temporary directory for GNUPGHOME.
	GNUPGHOME=$(mktemp -d)
	export GNUPGHOME
	echo "Temporary GNUPGHOME is $GNUPGHOME"
	echo "KeyID is ${KEYID}"

	# Create the gpg config file.
	echo "Setting up gpg.conf..."
	cat <<-EOF > "${GNUPGHOME}/gpg.conf"
	use-agent
	personal-cipher-preferences AES256 AES192 AES CAST5
	personal-digest-preferences SHA512 SHA384 SHA256 SHA224
	default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
	cert-digest-algo SHA512
	s2k-digest-algo SHA512
	s2k-cipher-algo AES256
	charset utf-8
	fixed-list-mode
	no-comments
	no-emit-version
	keyid-format 0xlong
	list-options show-uid-validity
	verify-options show-uid-validity
	with-fingerprint
	EOF

	echo "Setting up gpg-agent.conf..."
	cat <<-EOF > "${GNUPGHOME}/gpg-agent.conf"
	pinentry-program /usr/bin/pinentry
	enable-ssh-support
	use-standard-socket
	default-cache-ttl 600
	max-cache-ttl 7200
	EOF

	# Copy master key info to GNUPGHOME.
	# IMPORTANT: This is here as a stopper for anyone who runs this without reading it,
	# because it will exit here.
	# Modify this line to copy from a USB stick or your $HOME directory.
	echo "Copying master key from Google Cloud Storage..."
	gsutil -m cp ${HOME}/.gnupg/* "${GNUPGHOME}/"

	# Re-import the secret keys.
	gpg --import "${GNUPGHOME}/secring.gpg"

	# Update the default key in the gpg config file.
	echo "default-key ${KEYID}" >> "${GNUPGHOME}/gpg.conf"

	restart_agent
}

validate(){
	if gpg2 --with-colons --list-key "$KEYID" | grep -q "No public key"; then
		echo "I don't know any key called $KEYID"
		exit 1
	fi
}

generate_subkeys(){
	echo "Printing local secret keys..."
	gpg2 --list-secret-keys

	echo "Generating subkeys..."

	echo "Generating signing subkey..."
	echo addkey$'\n'4$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "Generating encryption subkey..."
	echo addkey$'\n'6$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "Generating authentication subkey..."
	echo addkey$'\n'8$'\n'S$'\n'E$'\n'A$'\n'q$'\n'$SUBKEY_LENGTH$'\n'"$SUBKEY_EXPIRE"$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "Printing local secret keys..."
	gpg2 --list-secret-keys
}

move_keys_to_card(){
	echo "Moving signing subkey to card..."
	echo "key 2"$'\n'keytocard$'\n'1$'\n'y$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "key 3"$'\n'keytocard$'\n'2$'\n'y$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "key 4"$'\n'keytocard$'\n'3$'\n'y$'\n'save$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --edit-key "$KEYID"

	echo "Printing card status..."
	gpg2 --card-status
}

update_cardinfo(){
	# Edit the smart card name and info values.
	echo "Updating card holder name..."
	echo admin$'\n'name$'\n'$SURNAME$'\n'$GIVENNAME$'\n'quit$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --card-edit

	echo "Updating card language..."
	echo admin$'\n'lang$'\n'en$'\n'quit$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --card-edit

	echo "Updating card login..."
	echo admin$'\n'login$'\n'"$EMAIL"$'\n'quit$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --card-edit

	echo "Updating card public key url..."
	echo admin$'\n'url$'\n'$PUBLIC_KEY_URL$'\n'quit$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --card-edit

	echo "Updating card sex..."
	echo admin$'\n'sex$'\n'$SEX$'\n'quit$'\n' | \
		gpg2 --expert --batch --display-charset utf-8 \
		--command-fd 0 --card-edit
}

finalize(){
	echo "Printing card status..."
	gpg2 --card-status

	echo
	echo "Printing local secret keys..."
	gpg2 --list-secret-keys

	echo
	echo "Temporary GNUPGHOME is $GNUPGHOME"

	gpg --armor --export "$KEYID" > "${HOME}/pubkey.txt"

	echo
	echo "Public key is ${HOME}/pubkey.txt"
	echo "You should upload it to a public key server"

	echo
	echo "Printing ssh key..."
	restart_agent
	ssh-add -L
}

setup_gnupghome
validate
generate_subkeys
move_keys_to_card
update_cardinfo
finalize
