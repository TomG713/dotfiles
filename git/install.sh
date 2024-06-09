#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

MARKER_FILE="$(dirname "$0")/git_updated"


# Function to use git ppa for latest version
git_ppa() {
  sudo apt-add-repository ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install -y git
}


# Main function
main() {
  if [[ -f "$MARKER_FILE" ]]; then
    log_info "Background already set. Skipping."
    exit 0
  fi

  detect_os
  
  case "$OS" in
    "Ubuntu")
      git_ppa
      log_success "git updated to latest version"
      ;;
    "macOS")
      touch "$MARKER_FILE"
      log_info "update script to install latest git for mac"
      ;;
    *)
      touch "MARKER_FILE"
      log_warning "Unsupported operating system."
      ;;
  esac

  # Create marker file to indicate script has run
  touch "$MARKER_FILE"
  log_success "Marker file created. The script will not run again."
}

main "$@"
