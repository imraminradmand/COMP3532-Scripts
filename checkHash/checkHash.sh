#!/bin/bash

providedHashValue=$(cat ./filehashoutput.txt)

for file in *{1..4}.txt; do
    hashedFile=$(sha512sum $file | grep -o '^\S*')

    if [[ $hashedFile == $providedHashValue ]]; then
	echo "${file} matches the hash signature"
	exit 0
    fi
done

echo "None of the files match the provided hash value"

exit 1>&2
