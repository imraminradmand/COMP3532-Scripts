#!/bin/bash

nflag='false'
lflag='false'
uflag='false'
dflag='false'
sflag='false'
eflag='false'

while getopts :nludse: opt; do
    case $opt in
        n) 
            randomPassword=cat /dev/urandom | tr -dc '^a-zA-Z0-9@#$%&' | fold -w 100 | head -n 1
            ;;
        l)
            lflag='true'
            ;;
        u) 
            uflag='true'
            ;;
        d)
            dflag='true'
            ;;
        s) 
            sflag='true'
            ;;
        e)  
            eflag='true'
            ;;
        *)
            ;;
    esac
done  

echo "nflag: $nflag"
echo $randomPassword
echo "lflag: $lflag"
echo "uflag: $uflag"
echo "dflag: $dflag"
echo "sflag: $sflag"
echo "eflag: $eflag"

