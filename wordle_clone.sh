#!/bin/bash

function check_word {
    wordToMatch=$1
    guessed=$2
    echo -e "The word being matched against is: \e[1;4m$wordToMatch\e[0m, the guessed input is: \e[1;4m$guessed\e[0m"
    for (( i=0; i<${#wordToMatch}; i++ )); do
	if [ ${wordToMatch:$i:1} == ${guessed:$i:1} ]; then
	    echo -e "\e[42m${guessed:$i:1}\e[0m"
	elif [[ ${wordToMatch} == *"${guessed:$i:1}"* ]]; then
	    echo -e "\e[43m${guessed:$i:1}\e[0m"
	else
	    echo -e "\e[41m${guessed:$i:1}\e[0m"
        fi
    done
}

six_letter_words=6letters.txt
echo "Welcome to this Wordle Clone - we do 6 letter words here"
read -p "Guess a five letter word to start: " guessedWord

length=${#guessedWord}

while [[ $length -lt 6 ]] || [[ $length -gt 6 ]]; do
    read -p "Incorrect length, try again: " guessedWord
    length=${#guessedWord}
done

randomWord=$(shuf -n 1 $six_letter_words)
echo $randomWord

while [ $guessedWord != $randomWord ]; do
    check_word $randomWord $guessedWord
    read -p "Your next guess: " guessedWord
done
