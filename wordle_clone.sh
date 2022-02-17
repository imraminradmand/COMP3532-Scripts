#!/bin/bash

echo "Weclome to this Wordle Clone"
read -p "Guess a five letter word to start: " guessedWord

length=${#guessedWord}

if [[ $length -lt 5 ]] || [[ $length -gt 5 ]]; then
    echo "incorrect length"
else
    echo "aight lets go"
fi
