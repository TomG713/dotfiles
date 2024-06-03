#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

set_default_shell_to_zsh() {
  if [ "$(uname)" == "Darwin" ]; then
    local current_shell
    current_shell=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
    if [ "$current_shell" != "$(which zsh)" ]; then
      if ! grep -q "$(which zsh)" /etc/shells; then
        log_info "Adding zsh to /etc/shells..."
        echo "$(which zsh)" | sudo tee -a /etc/shells
      fi
      log_info "Setting login shell to zsh..."
      chsh -s "$(which zsh)"
    fi
  elif [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
    if [ -z "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
      if [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
        log_info "Detected Bash. Switch to zsh by running: sudo chsh -s $(which zsh) $USER"
      else
        log_info "No Zsh or Bash detected. Switch to zsh by running: sudo chsh -s $(which zsh) $USER"
      fi
    fi
  fi
}

install_prezto() {
  if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    log_info "Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
  log_info "Updating Prezto..."
  cd "${ZDOTDIR:-$HOME}/.zprezto"
  git pull
  git submodule sync --recursive
  git submodule update --init --recursive
  log_success "Prezto updated successfully."
}

main() {
  set_default_shell_to_zsh
  install_prezto
  log_success "Zsh and Prezto setup completed."
}

main "$@"
