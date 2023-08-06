#!/usr/bin/env bash

if test ! $(which pyenv)
then
    echo "Installing pyenv for you."
    curl https://pyenv.run | bash
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

pyenv update