#!/bin/bash

NFLAG='false'
LENGTH=8
LFLAG='false'
UFLAG='false'
DFLAG='false';
SFLAG='false';
EFLAG='false';
PFLAG='false';

UPPER="A-Z"
LOWER="a-z"
DIGITS="0-9"
SYMBOL="@#$%&*"

NREGEX="-n\s?[0-9]*\s?"
LREGEX=
UREGEX=
DFLAG=
SREGEX=
EREGEX=
PREGEX=
while [ $# -gt 0 ]; do
if [[ $1 =~ $NREGEX ]]; then
    echo 'inside n if'
    if [ $# -gt 1 ]; then
             NFLAG='true'
             LENGTH=$2
             shift
    fi

elif ['-.*?l\s?']; then
    LFLAG='true'

elif ['-.*?u\s?']; then
    UFLAG='true'

elif ['-.*?d\s?']; then
    DFLAG='true'

elif ['-.*?s\s?']; then
    SFLAG='true'

elif ['-.*?e\s?']; then
    EFLAG='true'

elif ['-.*?p\s?']; then
    PFLAG='true'

else
    echo 'something'
fi
done

echo 'nflag : $NFLAG'
if [ $LENGTH -le 0 ]; then
    echo "passgen: invalid -n argument '$LENGTH'"
else

    if [ $LFLAG = 'false' -a $UFLAG = 'false' -a $DFLAG = 'false' -a $SFLAG = 'false' ]; then
        LFLAG=true
    fi
    
    if [ $EFLAG = 'true' ]; then
        LOWER="a-km-z"
        UPPER="A-HJ-NP-Z"
        DIGITS="2-9"
    fi
    
    CHARS=''
    if [ $LFLAG = 'true' ]; then
        CHARS="$LOWER$CHARS"
    fi
    if [ $UFLAG = 'true' ]; then
        CHARS="$UPPER$CHARS"
    fi
    if [ $DFLAG = 'true' ]; then
        CHARS="$DIGITS$CHARS"
    fi
    if [ $SFLAG = 'true' ]; then
        CHARS="$SYMBOL$CHARS"
    fi

    echo `tr -dc $CHARS < /dev/urandom | head -c${1:-$LENGTH};echo;`
fi
