#!/usr/bin/env bash

if [ ! -d ~/.vim_runtime ]
then
	# https://github.com/amix/vimrc
	echo "> installing vim settings"
	git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

cd ~/.vim_runtime
git reset --hard
git clean -d --force
git pull --rebase
python3 update_plugins.py 

