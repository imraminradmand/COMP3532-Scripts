#!/bin/bash

function check_word {
    wordToMatch=$1
    guessed=$2
    for (( i=0; i<${#wordToMatch}; i++ )); do
	if [ ${wordToMatch:$i:1} == ${guessed:$i:1} ]; then
	    echo -ne "\e[42m${guessed:$i:1}\e[0m"
	elif [[ ${wordToMatch} == *"${guessed:$i:1}"* ]]; then
	    echo -ne "\e[43m${guessed:$i:1}\e[0m"
	else
	    echo -ne "\e[41m${guessed:$i:1}\e[0m"
        fi
    done
}

six_letter_words=6letters.txt
tries=1
echo "Welcome to this Wordle Clone - we do 6 letter words here"
read -p "Guess a six  letter word to start: " guessedWord

length=${#guessedWord}

while [[ $length -lt 6 ]] || [[ $length -gt 6 ]]; do
    read -p "Incorrect length, try again: " guessedWord
    length=${#guessedWord}
done

randomWord=$(shuf -n 1 $six_letter_words)
echo $randomWord
while [ $tries -lt 7 ]; do
    echo $tries
    while [ $guessedWord != $randomWord ]; do
	check_word $randomWord $guessedWord
	echo
	read -p "Your next guess: " guessedWord
    done
    ((tries++))
    if [ $guessedWord == $randomWord ] && [ $tries -eq 1 ]; then
	echo "Got lucky eh?"
    elif [ $guessedWord == $randomWord ] && [ $tries -lte 3 ]; then
	echo "Nicely done!"
    elif [ $guessedWord == $randomWord ] && [ $tries -lte 5 ]; then
	 echo "Cutting it close..."
    else
	echo "Close call"
    fi
done

echo "Ran out of tries :( better luck next time"
