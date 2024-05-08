#!/usr/bin/env zsh

RUBY_VERSION=3.3.1

function install_ruby() {
  rbenv install ${RUBY_VERSION} --skip-existing
  rbenv global ${RUBY_VERSION}
}

if ! (( $+commands[rbenv] ))
then
  echo "Installing Ruby tools and Ruby ${RUBY_VERSION}"
  if [[ "$OSTYPE" == "linux*" ]]; then 
    # echo "using openssl dir /usr/lib/ssl, if this fails, try openssl version -d"
    # RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/lib/ssl && rbenv install "${RUBY_VERSION}" --skip-existing
    sudo apt install rbenv
  else
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
  eval "$(~/.rbenv/bin/rbenv init - zsh)"
  install_ruby
  gem install bundler
  rbenv rehash
fi

if (( $+commands[rbenv] ))
then
  # Update
  eval "$(command rbenv init -)"
  install_ruby
  echo "> updating gems"
  gem update && gem update --system 2>&1
fi


