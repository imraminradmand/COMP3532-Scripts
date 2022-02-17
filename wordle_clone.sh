#!/bin/bash

echo "Weclome to this Wordle Clone"
read -p "Guess a five letter word to start: " guessedWord

length=${#guessedWord}

while [[ $length -lt 5 ]] || [[ $length -gt 5 ]]; do
    read -p "Incorrect length, try again: " guessedWord
    length=${#guessedWord}
done
