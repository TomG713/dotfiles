#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

MARKER_FILE="$(dirname "$0")/set_background"
BACKGROUND_IMAGE="../misc/tree_tunnel.jpeg"

# Function to set the background
set_background() {
  gsettings set org.gnome.desktop.background picture-uri "file://$(realpath $BACKGROUND_IMAGE)"
  log_success "Background image set to $BACKGROUND_IMAGE"
}

# Main function
main() {
  if [ -f "$MARKER_FILE" ]; then
    log_info "Background already set. Skipping."
    exit 0
  fi

  set_background

  # Create marker file to indicate script has run
  touch "$MARKER_FILE"
  log_success "Marker file created. The script will not run again."
}

main "$@"

