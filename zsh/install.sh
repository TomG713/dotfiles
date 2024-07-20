#!/usr/bin/env bash

set -e

# Source the common functions, including detect_os and command_exists
source "$(dirname "$0")/../bin/common.sh"

# Function to set the default shell to Zsh
set_default_shell_to_zsh() {
  detect_os

  local zsh_path
  zsh_path=$(which zsh)
  if [ -z "$zsh_path" ]; then
    log_error "Zsh is not installed. Please install it and try again."
    exit 1
  fi

  case "$OS" in
    macOS)
      local current_shell
      current_shell=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
      if [ "$current_shell" != "$zsh_path" ]; then
        if ! grep -q "$zsh_path" /etc/shells; then
          log_info "Adding zsh to /etc/shells..."
          echo "$zsh_path" | sudo tee -a /etc/shells
        fi
        log_info "Setting login shell to zsh..."
        chsh -s "$zsh_path"
      fi
      ;;
    Ubuntu | WSL)
      if [ -z "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
        log_info "Setting login shell to zsh..."
        sudo chsh -s "$zsh_path" "$USER"
      fi
      ;;
    *)
      log_warning "Unsupported operating system."
      exit 1
      ;;
  esac
}

# Function to install Prezto
install_prezto() {
  if ! command_exists "git"; then
    log_error "Git is not installed. Please install it and try again."
    exit 1
  fi

  if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    log_info "Installing Prezto..."
    if ! git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null 2>&1; then
      log_error "Failed to clone Prezto repository."
      exit 1
    fi
  fi
  log_info "Updating Prezto..."
  cd "${ZDOTDIR:-$HOME}/.zprezto" || exit
  if ! git pull > /dev/null 2>&1; then
    log_error "Failed to update Prezto repository."
    exit 1
  fi
  if ! git submodule sync --recursive > /dev/null 2>&1; then
    log_error "Failed to sync Prezto submodules."
    exit 1
  fi
  if ! git submodule update --init --recursive > /dev/null 2>&1; then
    log_error "Failed to update Prezto submodules."
    exit 1
  fi
  log_success "Prezto updated successfully."
}


# Main function
main() {
  set_default_shell_to_zsh
  install_prezto
  log_success "Zsh and Prezto setup completed."
}

main "$@"
