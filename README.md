# COMP3532-Scripts
Collection of Shell scripts created in COMP 3532

1. **guessing_game.sh** : Simple number guessing game. Script will generate a random number between 1-100 and lets you guess. You also have the option to enable debugging.
2. **singleFunction_wordle.sh** : Single function that works like wordle, you pass the function 2 arguments, first one being the word the starting word, and the second being the "guessed" word that will be being matched against the first argument. If letters in the guessed word are at the same position as the "actual" word, the background will be set to green, if the letter is in the word but not the same position the background will be set to green, and if not in the word at all background will be set to red.
3. **wordle_clone.sh** : The names on it, its a shell script that allows you to play [Wordle](https://www.nytimes.com/games/wordle/index.html) with a few minor difference, at least as of right now. It gives you 7 attempts to guess a 6 letter word, versus the 6 guesses you get for the 5 letter word when playing the actual games. I have used the [Random Word API](http://random-word-api.herokuapp.com/home) to get a list of all words that the API had, then using a verrrry basic Python script separated the 6 letter words, and now we're here! Works like the actual game, just a little buggy but we'll get there **In Progress...**
4. **Assignment 1 Folder** : Pretty self explanitory what the folder is, but whats in it? </br>
        1. **passgen.sh** : This script will create a random password for you based on the flags you specify. The usage of the script is given when you run it. Lowercase, uppercase, password with special characters, digits, and passwords that do not include ambigious characters can be created using this script. </br>
        2. **pattern.sh** : This script will create a pattern justified to the right, center, or left with any given depth and any given character. The usage for this script is also given when you run it. </br>
        3. **install.sh** : Install script as you may have guessed, it will install the commands into your ~/bin directory and if you don't have one it'll create one. </br>


