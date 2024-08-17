#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export PYTHON_VERSION=3.12.5

install_or_update "python" "$PYTHON_VERSION" "python --version 2>&1 | awk '{print \$2}'"
