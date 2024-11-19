#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"
source "$(dirname "$0")/lang.sh"

main() {
    if ! command_exists mise; then
    detect_os

    case "$OS" in
        Darwin)
        install_mise_mac
        ;;
	    Ubuntu)
        install_mise_ubuntu
        ;;
        WSL)
        install_mise_ubuntu
        ;;
        *)
        log_error "Unsupported operating system: $OS"
        exit 1
        ;;
    esac

    else
        log_info "Mise is already installed"
        exit 0
    fi

    log_success "Mise install ompleted."

    install_lang
}

main "$@"
