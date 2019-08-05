if test ! $(which yarn)
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  nvm install node
  nvm install v12.7.0
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  sudo apt install --no-install-recommends yarn 
  yarn config set prefix /usr/local/
  yarn global add create-react-app npm webpack yo jest mocha
fi

