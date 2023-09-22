#!/usr/bin/env bash
#
# link dotfiles

install_dotfiles () {
  echo 'installing dotfiles'
  echo "from $DOTFILES_ROOT"

  rm .zshrc && ln -s $DOTFILES_ROOT/zsh/zshrc-saw $HOME/.zshrc
  rm .zpreztorc && ln -s $DOTFILES_ROOT/zsh/zpreztorc-saw $HOME/.zpreztorc
  rm .p10k.zsh && ln -s $DOTFILES_ROOT/zsh/p10k.zsh-saw $HOME/.p10k.zsh
}

install_dotfiles
