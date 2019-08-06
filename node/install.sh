NODE_VERSION=1.12.7
NVM_VERSION=0.34.0


if test ! $(which yarn)
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
  nvm install node
  nvm install v${NODE_VERSION}
  nvm use v${NODE_VERSION}
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  sudo apt install --no-install-recommends yarn 
  yarn config set prefix /usr/local/
  yarn global add create-react-app npm webpack yo jest mocha
fi

if test ! $(which yarn)
then
  # Update node
  echo "› node update"
  npm install npm@latest -g
  npm -g update yarn
  yarn global upgrade --latest
  npm -g update
fi

