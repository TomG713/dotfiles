if [[ ! -d ~/.vim/bin ]]
then
  git clone https://github.com/pivotal/vim-config.git ~/.vim
  ~/.vim/bin/install
fi
# ~/.vim/bin/update
