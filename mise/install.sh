#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

# Function to install mise on Ubuntu
install_mise_ubuntu() {
  sudo apt update -y && sudo apt install -y gpg sudo wget curl
  sudo install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg > /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
  sudo apt update
  sudo apt install -y mise
}

# Function to install mise on macOS
install_mise_mac() {
  brew install mise
}

main() {
    if ! command_exists mise; then
    detect_os

    case "$OS" in
        Linux)
        if [ -f /etc/lsb-release ] && grep -qi "ubuntu" /etc/lsb-release; then
            log_info "Detected Ubuntu. Installing mise..."
            install_mise_ubuntu
        else
            log_error "Unsupported Linux distribution. Only Ubuntu is supported."
            exit 1
        fi
        ;;
        Darwin)
        log_info "Detected macOS. Installing mise..."
        install_mise_mac
        ;;
        *)
        log_error "Unsupported operating system: $OS"
        exit 1
        ;;
    esac

    else
        log_info "Mise is already installed"
        exit 0
    fi

    log_success "Mise install ompleted."
}

main "$@"
