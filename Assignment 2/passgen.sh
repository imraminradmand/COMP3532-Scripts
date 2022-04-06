#!/bin/bash

LENGTH=8
NFLAG='false'
LFLAG='false'
UFLAG='false'
DFLAG='false'
SFLAG='false'
EFLAG='false'
PFLAG='false'

PASSWORD_REGEX=''

UPPER="A-Z"
LOWER="a-z"
DIGITS="0-9"
SYMBOL="@#$%&*"

LREGEX='l'
UREGEX='u'
DREGEX='d'
SREGEX='s'
EREGEX='e'
PREGEX='p'


# usage function will show help
usage() {                                 
  echo "Usage: $0 
    [-n --> Number of characters in password (must be >=1)] 
    [-l --> Specifies that lowercase letters should be used] 
    [-u --> Specifies that uppercase letters should be used]
    [-d --> Specifies that numerical digits should be used] 
    [-s --> Specifies that symbols should be used (i.e. @#$%&*)]
    [-e --> Easy to read. Exclude ambiguous characters (i.e. Il1o0)]
    [-p --> Pass a user to have their password changed (MUST BE RUN AS ROOT)] "1>&2 
}

# function to exit with error
exit_with_error() {
    usage
    exit 1
}

while [ $# -gt 0 ]; do

    # checking to see if arg starts with -
    if [[ $1 =~ ^[^-] ]]; then
        exit_with_error
    fi

    # checking to make sure flag is a valid flag
    if [[ $1 =~ ^[^nplues]*$ ]]; then
        exit_with_error
        echo "Non valid flag was entered."
    fi

    # check if n flag is followed by space
    if [[ "$1" =~ ^-n$ ]]; then
        NFLAG='true';
        # if the next arg is a number
        if [[ "$2" =~ ^[0-9]+$ ]]; then
            LENGTH=$2;
        # if the next arg is not number
        else
            exit_with_error
        fi
        shift
    # if n flag is without space  
    elif [[ "$1" =~ ^-n[A-Za-z0-9\.\-]+$ ]]; then
        NFLAG='true';
        new_length=${1:2};
        # make sure the substring is actually a number first
        if [[ $new_length =~ ^[0-9]+$ ]]; then
            LENGTH=$new_length
        else
            exit_with_error
        fi
    fi


    if [[ $1 =~ l ]]; then
        LFLAG='true'
    fi

    if [[ $1 =~ u]]; then
        UFLAG='true'
    fi

    if [[ $1 =~ d ]]; then
        DFLAG='true'
    fi

    if [[ $1 =~ s ]]; then
        SFLAG='true'
    fi

    if [[ $1 =~ e ]]; then
        EFLAG='true'
    fi

    # check if p flag is followed by a space
    if [[ "$1" =~ ^-p$ ]]; then
        PFLAG='true';
        if [[ $# -gt 1 ]]; then
            USERID=$2;
        fi
        shift
    elif [[ "$1" =~ ^-p[A-Za-z0-9\@\#\$\%\&]+$ ]]; then
        PFLAG='true';
        USERID=${1:2};
    fi
    shift
done

# ensuring that number is >= 1.
if [[ $LENGTH -le 1 ]]; then
    exit_with_error
fi

# lowercase regex for l flag
if [[ $LFLAG == 'true' ]]; then
    PASSWORD_REGEX+=$LOWER
fi

# uppercase regex for u flag
if [[ $UFLAG == 'true' ]]; then
    PASSWORD_REGEX+=$UPPER
fi

# digit regex for d flag
if [[ $DFLAG == 'true' ]]; then
    PASSWORD_REGEX+=$DIGITS
fi

# symbol regex for s flag
if [[ $SFLAG == 'true' ]]; then
    PASSWORD_REGEX+=$SYMBOL
fi

# If regex is empty, ie. if no flag has been specified add lowercase to regex to generate a base caase password
if [[ -z "$PASSWORD_REGEX" ]]; then
    PASSWORD_REGEX+=$LOWER
fi

# generate new password with specified flags
password=$(cat /dev/urandom | tr -dc $PASSWORD_REGEX | fold -w $LENGTH | head -n 1)

# generate password without ambigious characters
if [[ $EFLAG == 'true' ]]; then
   password=$(cat /dev/urandom | tr -dc $PASSWORD_REGEX | fold -w $LENGTH | head -n 1 | tr -d 'Il1o0')
fi

# Change password for user when p flag is specified
if [[ $PFLAG == 'true' ]]; then
    if [[ $EUID -ne 0 ]]; then
        echo "When using the '-p' flag you must run the script as root"
        exit_with_error
    elif ! id $USERID &>/dev/null; then
        echo "The user '$USERID' does not exist on the system."
        exit_with_error
    elif [ -z $USERID ]; then
        echo "You must have a USERID"
        exit_with_error
    else
        echo -e "The password for \e[4m$USERID\e[0m has been changed!" 
        echo -e "The new password is: $password"
        echo -e "$password\n$password" | passwd $USERID &>/dev/null
    fi
else
    # print password
    echo -e "The new generated password is: $password"
fi