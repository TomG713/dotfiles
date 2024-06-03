#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

if ! command_exists pyenv; then
  log_info "Installing pyenv..."
  curl https://pyenv.run | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

log_info "Updating pyenv..."
pyenv update
log_success "pyenv setup completed."
