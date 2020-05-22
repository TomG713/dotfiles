NODE_VERSION=14.1.0
NVM_VERSION=0.35.3


if test ! $(which yarn)
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
  nvm install node
  nvm install v${NODE_VERSION}
  nvm use v${NODE_VERSION}
  npm install -g yarn
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

