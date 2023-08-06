#!/usr/bin/env bash

if test ! $(which pyenv)
then
    echo "Installing pyenv for you."
    curl https://pyenv.run | bash
    eval "$(pyenv init -)"
fi

pyenv update