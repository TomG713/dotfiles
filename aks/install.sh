#!/usr/bin/env bash


if test ! $(which ktx)
then 
	echo "Installing ktx"
    	sudo curl https://raw.githubusercontent.com/blendle/kns/master/bin/ktx -o /usr/local/bin/ktx && sudo chmod +x $_
fi

if test ! $(which kns)
then
	echo "Installing kns"
	sudo curl https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && sudo chmod +x $_
fi
