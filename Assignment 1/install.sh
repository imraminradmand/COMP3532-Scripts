#!/bin/bash

if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

sudo chmod -R 751 passgen.sh pattern.sh

sudo install -t ~/bin passgen.sh pattern.sh

exit 0
