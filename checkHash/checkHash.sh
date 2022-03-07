#!/bin/bash

hashSignature=$(cat ./filehashoutput.txt)

for file in *{1..4}.txt; do
    hashedFile=$(sha512sum $file | grep -o '^\S*')

    if [[ $hashedFile == $hashSignature ]]; then
	echo "${file} matches the hash signature"
    fi
done

exit 0
