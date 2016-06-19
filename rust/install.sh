if [[ ! -x "$(which rustc)" ]]
  
then
  echo "  Installing rust for you."
  curl -sSf https://static.rust-lang.org/rustup.sh | sh
fi
