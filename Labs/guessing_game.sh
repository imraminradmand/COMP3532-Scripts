#!/bin/bash

# prompt user if they want to enable debug
read -p "Would you like to enable debugging?(y/n)  " debugResponse

if [ $debugResponse == "y" ]; then
    set -x
fi

play="y"
while [ $play == "y" ]; do
    random_number=$(($RANDOM%(100-1+1)+1))
    read -p "Guess the randomly generated number (between 1-100): " userGuess

    while [ $userGuess -ne $random_number ]; do
	if [ $userGuess -gt $random_number ]; then
	    read -p "Guessed too high, try again: " userGuess
	elif [ $userGuess -lt $random_number ]; then
	    read -p "Guessed too low, try again: " userGuess
	else
	echo "You did something weird..."
	fi
    done
    echo "Great, you guessed the number"
    read -p "Go again? (y/n): " play
    if [ $play == "y" ]; then
	continue
    else
	echo "Thanks for playing :)"
    fi
done
exit
