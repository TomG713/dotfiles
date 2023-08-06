#!/usr/bin/env bash

zplug () {
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

ohmy () {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

pure () {
	mkdir -p "$HOME/.zsh"
	git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
}

updatepure () {
	cd "$HOME/.zsh/pure"
	git reset --hard
	git clean -d --force
	git pull --rebase
}

if [ "$(uname)" == "Darwin" ]; then
    if [ ! $(dscl . -read /Users/$USER UserShell | awk '{print $2}') == $(which zsh) ]; then
		if ! cat /etc/shells | grep --quiet $(which zsh); then
			echo $(which zsh) | sudo tee -a /etc/shells
		fi
		echo "Setting login shell to zsh" && chsh -s $(which zsh)
		ohmy
		pure
	    zplug
	fi     
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
		echo ''
	elif [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
		echo 'Detected Bash switching to zsh'
		echo 'please run sudo chsh -s $(which zsh) $USER'
		ohmy
		pure
		zplug
	else
	  	echo 'No Zsh or Bash detected - switching to zsh'
		echo 'please run sudo chsh -s $(which zsh) $USER'
		ohmy
		pure
		zplug
	fi
fi

updatepure