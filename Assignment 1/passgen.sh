#!/bin/bash

# regex intialization
regex='a-z'

# setting all the flags to default values
length=8
lower='false'
upper='false'
digits='false'
symbols='false'
easy='false'

# function to show how script works
usage() {                                 
  echo "Usage: $0 
    [-n --> length of characters in password (must be >=1)] 
    [-l --> Specifies that lowercase letters should be used] 
    [-u --> Specifies that uppercase letters should be used]
    [-d --> Specifies that numerical digits should be used] 
    [-s --> Specifies that symbols should be used (i.e. @#$%&*)]
    [-e --> Easy to read. Exclude ambiguous characters (i.e. Il1o0)]" 1>&2 
}

# function to exit with error
exit_function() {
    usage
    exit 1
}

while getopts ":n:ludse" options; do
  case "${options}" in
    n) 
        # length flag
        length=${OPTARG:-8} 
        ;;
    l) 
        # lowercase flag
        lower='true'
        ;;
    u) 
        # uppercase flag
        upper='true'
        ;;
    d) 
        # digits flag
        digits='true'
        ;;
    s) 
        # special character flag
        symbols='true'
        ;;
    e) 
        # easy to read flag
        easy='true'
        ;;
     :)
        # argument expected but not present
        echo "Error: -${OPTARG} argument is required!"
        exit_function
        ;;
    *)
        # unkown flag is passed
        exit_function
        ;;
  esac
done
########### ERROR CHECKING ###########
# ensuring that length is >= 1.
######################################
if [[ $length -le 1 ]]; then
    exit_function
fi

######################## REGEX MODIFICATION ###################
# concating to intial regex variable based on whichever flags 
# that have been turned on by the user
#############################################################
if [[ $lower == 'true' ]]; then
    regex+='a-z'
fi

if [[ $upper == 'true' ]]; then
    regex+='A-Z'
fi

if [[ $digits == 'true' ]]; then
    regex+='0-9'
fi

if [[ $symbols == 'true' ]]; then
    regex+='@#$%&'
fi

if [[ $symbols == 'true' ]]; then
    regex+='@#$%&'
fi


################# MAIN PASSWORD GENERATOR ##############################
password=$(cat /dev/urandom | tr -dc $regex | fold -w $length | head -n 1)

################# PASSWORD EXCLUDING AMBIGUOUS CHARACTERS ################
if [[ $easy == 'true' ]]; then
   password=$(cat /dev/urandom | tr -dc $regex | fold -w $length | head -n 1 | tr -d 'Il1o0')
fi

echo $password

exit 0
