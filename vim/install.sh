echo "> validating vim install"

NVIM_VERSION=0.5.1

if [ ! -d ~/.vim ]
then
	pip install setuptools
	pip3 install pynvim
	pip2 install pynvim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi
echo "> completed"
