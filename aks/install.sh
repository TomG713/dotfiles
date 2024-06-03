#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

install_tool() {
  local tool=$1
  local url=$2
  if ! command_exists "$tool"; then
    log_info "Installing $tool..."
    sudo curl -L "$url" -o /usr/local/bin/$tool
    sudo chmod +x /usr/local/bin/$tool
    log_success "$tool installed successfully."
  else
    log_info "$tool is already installed."
  fi
}

main() {
  install_tool ktx "https://raw.githubusercontent.com/blendle/kns/master/bin/ktx"
  install_tool kns "https://raw.githubusercontent.com/blendle/kns/master/bin/kns"
}

main "$@"
