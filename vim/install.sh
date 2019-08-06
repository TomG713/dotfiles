echo "> validating vim install"

if [ ! -d ~/.vim ]
  # then
#  git clone https://github.com/luan/vimfiles ~/.vim
#  pip3 install --upgrade neovim
#  ~/.vim/bin/install
# fi
#~/.vim/bin/update
then
	git clone --recursive https://github.com/jessfraz/.vim.git $HOME/.vim
	ln -sf $HOME/.vim/vimrc $HOME/.vimrc
	cd $HOME/.vim
	git submodule update --init
else
	echo "> updating vim settings"
	cd $HOME/.vim
	make update 
fi

