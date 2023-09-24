#!/usr/bin/env zsh

RUBY_VERSION=3.2.2

function install_ruby() {
  if [[ "$OSTYPE" == "linux*" ]]; then 
    echo "using openssl dir /usr/lib/ssl, if this fails, try openssl version -d"
    RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/lib/ssl && rbenv install "${RUBY_VERSION}" --skip-existing
  else
    rbenv install ${RUBY_VERSION} --skip-existing
  fi
}

if ! (( $+commands[rbenv] ))
then
  echo "Installing Ruby tools and Ruby ${RUBY_VERSION}"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  eval "$(~/.rbenv/bin/rbenv init - zsh)"
  install_ruby
  rbenv global ${RUBY_VERSION}
  gem install bundler
  rbenv rehash
fi

if (( $+commands[rbenv] ))
then
  # Update
  eval "$(command rbenv init -)"
  install_ruby
  rbenv global $RUBY_VERSION
  echo "> updating gems"
  gem update && gem update --system 2>&1
fi


