#!/usr/bin/env bash

# these need to be updated based on versions intalled by apt/brew
export APT_DEFAULT=11
export APT_LATEST=19
export BREW_LATEST=20.0.1

if test ! $(which jenv)
then
    git clone https://github.com/jenv/jenv.git ~/.jenv
    export PATH="$HOME/.jenv/bin:$PATH"
    mkdir -p ~/.jenv/versions
    eval "$(jenv init -)"
    jenv enable-plugin export

    if [ "$(uname)" == "Darwin" ]; then
        jenv add "$(/usr/libexec/java_home)"
        jenv add /usr/local/Cellar/openjdk/${BREW_LATEST}
        jenv global ${BREW_LATEST}
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        #jenv add "$(/usr/lib/jvm/java-{APT_DEFAULT}-openjdk-amd64)"
        #jenv add "$(/usr/lib/jvm/java-{APT_LATEST}-openjdk-amd64)"
        jenv global ${APT_LATEST}
	jenv add
    fi 
fi
