echo "> validating vim install"

NVIM_VERSION=0.9.1

if [ ! -d ~/.vim ]

then
	pip install setuptools
	pip3 install pynvim
	pip2 install pynvim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi
echo "> completed"

# then
#  git clone https://github.com/luan/vimfiles ~/.vim
#  pip3 install --upgrade neovim
#  ~/.vim/bin/install
# fi
#~/.vim/bin/update
# git clone --recursive https://github.com/jessfraz/.vim.git $HOME/.vim
# ln -sf $HOME/.vim/vimrc $HOME/.vimrc
# cd $HOME/.vim
# curl vimfiles.luan.sh/install | FORCE=1 bash	
# git submodule update --init
# else
# echo "> updating vim settings"
# cd $HOME/.vim
# make update 
