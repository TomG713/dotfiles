#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"

# Install jenv if not already installed
install_jenv() {
  log_info "Installing jenv..."
  git clone https://github.com/jenv/jenv.git ~/.jenv
  export PATH="$HOME/.jenv/bin:$PATH"
  mkdir -p ~/.jenv/versions
  eval "$(jenv init -)"
  jenv enable-plugin export
}

# Get the latest Java version available on macOS using Homebrew
get_latest_java_version_macos() {
  brew update > /dev/null
  brew search openjdk | grep -Eo 'openjdk@[0-9]+' | sort -r | head -n 1 | grep -Eo '[0-9]+'
}

# Get the latest Java version available on Ubuntu using apt
get_latest_java_version_ubuntu() {
  sudo apt-get update > /dev/null
  apt-cache search openjdk | grep -Eo 'openjdk-[0-9]+-jdk' | grep -Eo '[0-9]+' | sort -r | head -n 1
}

add_java_version_to_jenv() {
  local java_path="$1"
  local java_version="$2"

  if ! jenv versions --bare | grep -q "^${java_version}$"; then
    log_info "Adding Java $java_version to jenv..."
    jenv add "$java_path"
  else
    log_info "Java $java_version already present in jenv. Skipping addition."
  fi
}

install_java_macos() {
  local latest_java_version
  latest_java_version=$(get_latest_java_version_macos)
  log_info "Latest Java version on macOS: $latest_java_version"
  brew install openjdk@"$latest_java_version"
  local java_path
  java_path=$(brew --prefix)/opt/openjdk@"$latest_java_version"
  add_java_version_to_jenv "$java_path" "openjdk64-$latest_java_version"
  jenv global "openjdk64-$latest_java_version"
}

install_java_ubuntu() {
  local latest_java_version
  latest_java_version=$(get_latest_java_version_ubuntu)
  log_info "Latest Java version on Ubuntu: $latest_java_version"
  sudo apt-get install -y openjdk-"$latest_java_version"-jdk
  local java_path="/usr/lib/jvm/java-${latest_java_version}-openjdk-amd64"
  add_java_version_to_jenv "$java_path" "1.$latest_java_version"
  jenv global "1.$latest_java_version"
}

install_java_versions() {
  log_info "Installing required Java versions..."

  if [ "$(uname)" == "Darwin" ]; then
    install_java_macos
  elif [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
    install_java_ubuntu
  else
    log_error "Unsupported operating system."
  fi

  log_success "Java versions installed and configured with jenv."
}

main() {
  if ! command_exists jenv; then
    install_jenv
  else
    log_info "jenv is already installed."
    eval "$(jenv init -)"
  fi

  install_java_versions
  eval "$(jenv init -)"
  log_success "Java setup completed successfully."
}

main "$@"
