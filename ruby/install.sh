#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

log_info "Updating gems..."

# Suppressing specific output lines
{
    gem update 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
} || true

{
    gem update --system 2>&1 | grep -v -E "Updating installed gems|Nothing to update|Latest version already installed. Done."
} || true

log_success "Ruby setup and gem update completed."
