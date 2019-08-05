RUBY_VERSION=2.4.1

if test ! $(which rbenv)
then
  echo
  echo "Installing Ruby tools and Ruby ${RUBY_VERSION}"
  eval "$(rbenv init -)"
  rbenv install ${RUBY_VERSION} --skip-existing
  rbenv global ${RUBY_VERSION}
  gem install bundler
  rbenv rehash
fi
