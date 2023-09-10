#!/usr/bin/env bash

# automate this later


if test ! $(which ktx)
then 
	echo "Install ktx"
    	echo "curl https://raw.githubusercontent.com/blendle/kns/master/bin/ktx -o /usr/local/bin/ktx && chmod +x $_"
fi

if test ! $(which kns)
then
	echo "Install kns"
	echo "curl https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && chmod +x $_"
fi
