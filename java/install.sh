#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export JAVA_VERSION=22.0.2

install_or_update "java" "$JAVA_VERSION" "java -version 2>&1 | awk -F '\"' '/version/ {print \$2}'"
