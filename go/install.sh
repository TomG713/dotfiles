#!/usr/bin/env bash
# needs testing

export GO_VERSION=1.21.3

if test ! $(which go)
then
    echo "Installing go for you."
    if [ "$(uname)" == "Darwin" ]; then
        gofile=go${GO_VERSION}.darwin-arm64.pkg 
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        gofile=go${GO_VERSION}.linux-amd64.tar.gz 
    fi
    curl -LJO https://go.dev/dl/${gofile}
    sudo tar -C /usr/local -xzf ${gofile}
    rm ${gofile}
    export PATH=$PATH:/usr/local/go/bin
    go version
fi
