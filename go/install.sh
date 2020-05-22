GO_VERSION=1.14.2

if test ! $(which gvm)
then
  echo "Installing gvm for you."
	curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
  source $HOME/.gvm/scripts/gvm
  gvm install go${GO_VERSION}
  gvm use go${GO_VERSION}
fi
