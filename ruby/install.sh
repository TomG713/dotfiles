RUBY_VERSION=3.2.2

if test ! $(which rbenv)
then
  echo
  echo "Installing Ruby tools and Ruby ${RUBY_VERSION}"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  eval "$(rbenv init -)"
  rbenv install ${RUBY_VERSION} --skip-existing
  rbenv global ${RUBY_VERSION}
  gem install bundler
  rbenv rehash
fi

if test $(which rbenv)
then
  # Update 
  eval "$(command rbenv init -)"
  rbenv install $RUBY_VERSION --skip-existing
  rbenv global $RUBY_VERSION
  echo "> updating gems"
  gem update && gem update --system 2>&1
fi
