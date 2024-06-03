#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

export GO_VERSION=1.22.3

if ! command_exists go; then
  log_info "Installing Go ${GO_VERSION}..."
  if [ "$(uname)" == "Darwin" ]; then
    gofile=go${GO_VERSION}.darwin-arm64.pkg
  elif [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
    gofile=go${GO_VERSION}.linux-amd64.tar.gz
  fi
  curl -LJO https://go.dev/dl/${gofile}
  sudo tar -C /usr/local -xzf ${gofile}
  rm ${gofile}
  export PATH=$PATH:/usr/local/go/bin
else
  go_version_installed=$(go version | grep -o "go[0-9.]*")
  if [ "$go_version_installed" != "go${GO_VERSION}" ]; then
    log_info "Updating to Go ${GO_VERSION}..."
    go env -w GOTOOLCHAIN=go${GO_VERSION}+auto
  fi
  log_info "Go version is $(go version)"
fi
log_success "Go setup completed."
