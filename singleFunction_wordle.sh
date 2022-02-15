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


check_word works wroka

check_word mru uofc

check_word alberta ontario

check_word comp3532 comp3512
