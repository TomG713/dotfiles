#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/log-helper"
source "$(dirname "${BASH_SOURCE[0]}")/mise-helper"

# Check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to detect the operating system
detect_os() {
    case "$(uname)" in
        Darwin)
            OS="macOS"
            ;;
        Linux)
            if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
                OS="WSL"
            elif [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" == "ubuntu" ]; then
                    OS="Ubuntu"
                else
                    #OS=$NAME
                    OS="Unsupported"
                fi
            else
                OS="Unsupported"
                #OS="Linux"
            fi
            ;;
        *)
            OS="Unsupported"
            ;;
    esac
    # echo "Detected OS: $OS"
}
