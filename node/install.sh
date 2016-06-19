if test ! $(which ncu)
then
  npm install npm-check-updates -g
fi

if test ! $(which webpack)
then
  npm install webpack -g
fi
