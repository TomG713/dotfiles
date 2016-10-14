if [[ ! -d ~/.vim/bin ]]
then
  git clone https://github.com/luan/vimfiles ~/.vim
  pip3 install --upgrade neovim
  ~/.vim/bin/install
fi
~/.vim/bin/update
