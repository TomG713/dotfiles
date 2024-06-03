#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

REPO_URL="https://github.com/ryanoasis/nerd-fonts.git"
DIR_NAME="nerd-fonts"
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"

main() {
  if [ -d "$FONT_DIR" ]; then
    log_info "NerdFonts directory already exists at $FONT_DIR. Skipping installation."
    exit 0
  fi

  log_info "Cloning the NerdFonts repository..."
  git clone --depth 1 $REPO_URL

  if [ $? -eq 0 ]; then
    log_success "Cloned the repo successfully."
  else
    log_error "Failed to clone the repo."
  fi

  cd $DIR_NAME

  log_info "Running the install script..."
  ./install.sh

  if [ $? -eq 0 ]; then
    log_success "Installation completed successfully."
  else
    log_error "Installation failed."
  fi

  cd ..
  rm -rf $DIR_NAME

  if [ $? -eq 0 ]; then
    log_success "Deleted the repo successfully."
  else
    log_error "Failed to delete the repo."
  fi
}

main "$@"
