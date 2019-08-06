GO_VERSION=1.12.7

if test ! $(which go)
then
  echo "  Installing gofor you."
  curl -O https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
  sudo tar xvf go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local/go
  rm go${GO_VERSION}.linux-amd64.tar.gz
  source ./path.zsh
  go get golang.org/x/tools/cmd/godoc
  go get github.com/golang/lint/golint
fi
