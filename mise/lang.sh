#!/usr/bin/env bash

set -e
source "$(dirname "$0")/../bin/common.sh"

MISE_TOML="$(dirname "$0")/../mise/mise.local.toml.symlink"

main() {
    echo "Starting installation process..."

    # Ensure mise.toml exists
    if [[ ! -f "$MISE_TOML" ]]; then
        log_error "Mise.toml file not found at $MISE_TOML"
        exit 1
    fi

    local upgrade=false
    for arg in "$@"; do
        case "$arg" in
            --upgrade|-u)
                upgrade=true
                ;;
        esac
    done

    # Extract versions from mise.toml
    GO_VERSION=$(get_version_from_mise "go" "$MISE_TOML")
    PYTHON_VERSION=$(get_version_from_mise "python" "$MISE_TOML")
    JAVA_VERSION=$(get_version_from_mise "java" "$MISE_TOML")
    NODE_VERSION=$(get_version_from_mise "node" "$MISE_TOML")
    RUBY_VERSION=$(get_version_from_mise "ruby" "$MISE_TOML")

    # Debug: Log extracted versions
    log_info "Extracted versions:"
    log_info "  Go: $GO_VERSION"
    log_info "  Python: $PYTHON_VERSION"
    log_info "  Java: $JAVA_VERSION"
    log_info "  Node: $NODE_VERSION"

    # Install or update tools
    install_or_update "go" "$GO_VERSION" "go version | awk '{print \$3}' | sed 's/go//'" "$upgrade"
    install_or_update "python" "$PYTHON_VERSION" "python --version 2>&1 | awk '{print \$2}'" "$upgrade"
    install_or_update "java" "$JAVA_VERSION" "java -version 2>&1 | awk -F '\"' '/version/ {print \$2}'" "$upgrade"
    install_or_update "node" "$NODE_VERSION" "node -v | sed 's/v//'" "$upgrade"
    install_or_update "ruby" "$RUBY_VERSION" "ruby --version 2>&1 | awk '{print \$2}'" "$upgrade"

    echo "Installation process completed."
}

main "$@"
