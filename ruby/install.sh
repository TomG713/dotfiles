#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export RUBY_VERSION=3.3.3

install_or_update "ruby" "$RUBY_VERSION" "ruby --version 2>&1 | awk '{print \$2}'"

log_info "Updating gems..."
gem update && gem update --system 2>&1
log_success "Ruby setup and gem update completed."
