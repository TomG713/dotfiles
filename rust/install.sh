if [ ! -x "$(which rustc)" ]
then
  echo "  Installing rust for you."
  curl https://sh.rustup.rs -sSf | sh
fi
