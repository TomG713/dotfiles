#!/bin/zsh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node --latest-npm
nvm use node
echo "*****manually run nvm upgrade as needed******"

if test ! $(which yarn)
then
  npm install -g yarn
  yarn config set prefix /usr/local/
  yarn global add npm webpack yo jest mocha
fi

if test ! $(which yarn)
then
  ## validate if needed 
  npm install npm@latest -g
  npm -g update yarn
  yarn global upgrade --latest
  npm -g update
fi


