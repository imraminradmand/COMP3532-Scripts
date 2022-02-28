#!/bin/bash

# setting variables to default values
nflag=false
jflag=false
cflag=false
justification=leftcenterright

# function to show how script works
usage() {                                 
  echo "Usage: $0 
    [-n --> Specifies the depth of the pattern. (Must be: >= 1)] 
    [-j --> Specifies justification of the pattern. Default justification is left. Justification must be: left, center, or right.] 
    [-c --> Specifies the character used to fill out the pattern. Default character is *.]" 1>&2 
}

# function to exit with error
exit_function() {
    usage
    exit 1
}

while getopts ":n:j:c:" opts; do
    case "${opts}" in
        n) 
            nflag=true
            narg=${OPTARG}
            ;;
        j)
            jflag=true
            jarg=${OPTARG}
            ;;
        c)
            cflag=true
            carg=${OPTARG:-*}
            ;;
        *)
            exit_function
            ;;

    esac
done

########## BASE CASE FOR CHARACTER FLAG ###########
if [[ $cflag == 'false' ]]; then
    carg=*
fi 

############ ERROR CHECKING #######################
if [[ $nflag == 'false' ]]; then
    exit_function
fi

if [[ $narg -le 0 ]]; then
   exit_function
fi

if [[ $justification != *$jarg* ]]; then
  exit_function
fi


############ MAIN FUNCTIONALITY #######################
if [[ $jarg == 'left' ]]; then
    toPrint=$carg
    for (( i=1; i<= $narg; i++ )); do
        echo "$toPrint"
        toPrint+="$carg"
    done
fi

if [[ $jarg == 'center' ]]; then
    toPrint=$carg
    rows=$narg
    for((i=1; i<=rows; i++)); do
        for((j=1; j<=rows - i; j++)); do
            echo -n "  "
        done
        for((j=1; j<=2*i - 1; j++)); do
            echo -n "$toPrint "
        done
    echo
    done
fi

if [[ $jarg == 'right' ]]; then
    toPrint=$carg
    COLUMNS=$(tput cols)
    for (( i=1; i<= $narg; i++ )); do
        printf "%*s\n" $COLUMNS "$toPrint"
        toPrint+="$carg"
    done
fi

if [[ $jflag == 'false' ]]; then
    toPrint=$carg
    for (( i=1; i<= $narg; i++ )); do
        echo "$toPrint"
        toPrint+="$carg"
    done
fi

exit 0
