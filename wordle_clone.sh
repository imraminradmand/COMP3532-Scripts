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
allowedAttempts=7
echo "Welcome to this Wordle Clone - we do 6 letter words here"
read  -p "Guess a six  letter word to start: " guessedWord

length=${#guessedWord}
while [[ $length -lt 6 ]] || [[ $length -gt 6 ]]; do
    read -p "Incorrect length, go again: " guessedWord
    length=${#guessedWord}
done

randomWord=$(shuf -n 1 $six_letter_words)
#echo $randomWord


while [[ $guessedWord != $randomWord ]] && [[ $allowedAttempts -ne 0 ]]; do
    ((--allowedAttempts))
    echo $allowedAttempts
    check_word $randomWord $guessedWord
    echo
    read  -p "Your next guess: " guessedWord
    length=${#guessedWord}
    while [[ $length -lt 6 ]] || [[ $length -gt 6 ]]; do
        read -p "Incorrect length, go again: " guessedWord
        length=${#guessedWord}
    done
done

if (( $guessedWord == $randomWord )) && (( allowedAttempts == 6 )); then
    echo "Got lucky eh?"
elif (( $guessedWord == $randomWord )) && (( allowedAttempts >= 3 )); then
    echo "Nicely done!"
elif (( $guessedWord == $randomWord )) && (( allowedAttempts <= 2 )) && (( allowedAttempts != 0 )); then
    echo "Cutting it close..."
elif (( allowedAttemps == 0)); then
    echo "Ran out of attempts :( better luck next time"
fi
