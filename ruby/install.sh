#!/usr/bin/env zsh

set -e

source "$(dirname "$0")/../bin/common.sh"

RUBY_VERSION=3.3.1

install_ruby() {
  rbenv install ${RUBY_VERSION} --skip-existing
  rbenv global ${RUBY_VERSION}
}

if ! command_exists rbenv; then
  log_info "Installing Ruby tools and Ruby ${RUBY_VERSION}..."
  if [[ "$OSTYPE" == "linux*" ]]; then
    sudo apt install -y rbenv
  else
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
  eval "$(~/.rbenv/bin/rbenv init - zsh)"
  install_ruby
  gem install bundler
  rbenv rehash
fi

if command_exists rbenv; then
  eval "$(command rbenv init -)"
  install_ruby
  log_info "Updating gems..."
  gem update && gem update --system 2>&1
  log_success "Ruby setup and gem update completed."
fi
