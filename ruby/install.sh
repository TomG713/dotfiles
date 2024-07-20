#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export RUBY_VERSION=3.3.4

install_or_update "ruby" "$RUBY_VERSION" "ruby --version 2>&1 | awk '{print \$2}'"

log_info "Updating gems..."
{
    gem update 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
    gem update --system 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
} || {
    log_warning "There was an error during gem update. Continuing..."
}

log_success "Ruby setup and gem update completed."

