if [[ ! -d $GOPATH/src/github.com ]]
then
  echo "  Installing go packages for you."
  go get golang.org/x/tools/cmd/godoc
  go get github.com/golang/lint/golint
fi
