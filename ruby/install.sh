#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export RUBY_VERSION=3.3.6

install_or_update "ruby" "$RUBY_VERSION" "ruby --version 2>&1 | awk '{print \$2}'"

log_info "Updating gems..."

# Suppressing specific output lines
{
    gem update 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
} || true

{
    gem update --system 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
} || true

log_success "Ruby setup and gem update completed."
