#!/usr/bin/env bash

# these need to be updated based on versions intalled by apt
export DEFAULT=11
export LATEST=19

if test ! $(which jenv)
then
    git clone https://github.com/jenv/jenv.git ~/.jenv
    eval "$(jenv init -)"
    jenv enable-plugin export

    if [ "$(uname)" == "Darwin" ]; then
        jenv add "$(/usr/libexec/java_home)"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        jenv add "$(/usr/lib/jvm/java-${DEFAULT}-openjdk-amd64)"
        jenv add "$(/usr/lib/jvm/java-${LATEST}-openjdk-amd64)"
    fi 
fi