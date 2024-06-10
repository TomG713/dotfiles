#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

install_rust() {
  log_info "Installing Rust using rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  log_success "Rust installed successfully."
}

install_ubuntu_dependencies() {
  log_info "Installing dependencies on Ubuntu..."
  sudo apt-get update
  sudo apt-get install -y build-essential curl
}

install_macos_dependencies() {
  log_info "Installing dependencies on macOS..."
  if ! command_exists brew; then
    log_info "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  brew install curl
}



main() {

  if [ -x "$HOME/.cargo/bin/rustc" ]; then
      source "$HOME/.cargo/env"
      log_info "Rust is already installed. Version: $(rustc --version)"
      exit 0
  fi

  detect_os

  case "$OS" in
    "macOS")
      log_info "Detected macOS"
      install_macos_dependencies
      ;;
    "Ubuntu")
      log_info "Detected Linux"
      install_ubuntu_dependencies
      ;;
    "WSL")
      log_info "Detected Linux"
      install_ubuntu_dependencies
      ;;
    *)
      log_error "Unsupported operating system - $OS"
      ;;
  esac

  install_rust

  if command_exists rustc; then
    log_info "Rust installation completed successfully. Version: $(rustc --version)"
  else
    log_error "Rust installation failed."
  fi
}

main "$@"
