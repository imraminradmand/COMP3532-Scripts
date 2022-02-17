#!/bin/bash

six_letter_words=6letters.txt
echo "Weclome to this Wordle Clone"
read -p "Guess a five letter word to start: " guessedWord

length=${#guessedWord}

while [[ $length -lt 5 ]] || [[ $length -gt 5 ]]; do
    read -p "Incorrect length, try again: " guessedWord
    length=${#guessedWord}
done

randomWord=$(shuf -n 1 $six_letter_words)
echo $randomWord
