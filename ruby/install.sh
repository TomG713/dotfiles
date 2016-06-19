if [[ ! -x "$(which rbenv)" ]]
then
  echo
  echo "Installing Ruby tools and Ruby 2.3.1"
  eval "$(rbenv init -)"
  rbenv install 2.3.1 --skip-existing
  rbenv global 2.3.1
  gem install bundler
  rbenv rehash
fi
