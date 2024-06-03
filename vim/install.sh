#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

VIM_RUNTIME_DIR="$HOME/.vim_runtime"
VIM_REPO_URL="https://github.com/amix/vimrc.git"
INSTALL_SCRIPT="$VIM_RUNTIME_DIR/install_awesome_vimrc.sh"

install_vim_settings() {
  log_info "Installing Vim settings..."
  git clone --depth=1 "$VIM_REPO_URL" "$VIM_RUNTIME_DIR"
  sh "$INSTALL_SCRIPT"
}

update_vim_settings() {
  log_info "Updating Vim settings..."
  cd "$VIM_RUNTIME_DIR"
  git fetch
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})

  if [ "$LOCAL" != "$REMOTE" ]; then
    git reset --hard
    git clean -d --force
    git pull --rebase
    python3 update_plugins.py
  else
    log_info "Skipping vim plugin update - no repo changes"
  fi
}

main() {
  if [ ! -d "$VIM_RUNTIME_DIR" ]; then
    install_vim_settings
  else
    update_vim_settings
  fi

  log_success "Vim setup completed successfully."
}

main "$@"
