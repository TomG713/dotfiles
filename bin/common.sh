#!/usr/bin/env bash

# Log an info message
log_info() {
  printf "\r  [ \033[00;34mINFO\033[0m ] $1\n"
}

# Log a success message
log_success() {
  printf "\r\033[2K  [ \033[00;32mSUCCESS\033[0m ] $1\n"
}

# Log a warning message
log_warning() {
  printf "\r  [ \033[0;33mWARNING\033[0m ] $1\n"
}

# Log an error message and exit
log_error() {
  printf "\r\033[2K  [ \033[0;31mERROR\033[0m ] $1\n"
  exit 1
}

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
            OS="Ubuntu"
            ;;
        *)
            if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
              log_warning "The system is running WSL"
              OS="WSL"
            else
              log_warning "Unsupported operating system."
              OS="Unsupported"
            fi
            ;;
    esac

}

# Function to check if a string is a valid version number
is_valid_version() {
  [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

# Function to install or update a language using mise
install_or_update() {
  local lang=$1
  local version=$2
  local current_version_cmd=$3

  if ! command_exists $lang; then
    log_info "Installing $lang $version"
    mise use -g $lang@$version
  else
    # Run the command and capture the output
    output=$(mise ls-remote $lang)

    # Filter and sort the versions, then get the latest one
    latest_version=$(echo "$output" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

    # Ensure that mise environment is loaded
    export PATH="$HOME/.mise/bin:$PATH"
    eval "$(mise env)"

    # Extract the current version of the language
    current_version=$(eval "$current_version_cmd")

    # Debugging output to check current_version
    log_info "Extracted current $lang version: $current_version"

    if [ "$current_version" != "$version" ]; then
      log_info "Updating to $lang $version"
      mise use -g $lang@$version
      # Ensure that the new version is active
      eval "$(mise env)"
      new_version=$(eval "$current_version_cmd")
      log_info "Newly set $lang version: $new_version"
      if [ "$new_version" != "$version" ]; then
        log_error "Failed to update to $lang $version. Currently set to $new_version."
      fi
    elif [ "$latest_version" != "$current_version" ]; then
      log_warning "$lang version is $current_version but the latest version is $latest_version"
    else
      log_success "Already using latest version $version"
    fi
  fi
}