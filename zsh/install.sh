if [ ! $(dscl . -read /Users/$USER UserShell | awk '{print $2}') == $(which zsh) ]; then
	if ! cat /etc/shells | grep --quiet $(which zsh); then
		echo $(which zsh) | sudo tee -a /etc/shells
	fi
	echo "Setting login shell to zsh" && chsh -s $(which zsh)
fi

