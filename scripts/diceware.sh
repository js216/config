#!/bin/bash

usage() {
    echo "diceware.sh - a tool to select random words from a source, to generate a strong passphrase"
    echo ""
    echo "Usage:"
    echo "dice.sh /path/to/source/text [selection_count]"
    echo "  /path/to/source/text - mandatory filepath to source text file"
    echo "  selection_count - optional, number of random words to select from source, defaults to 7"
}

main() {
    source=$1
    select_count=$2

    if [ -z "$source" ] || [ "$source" == "-h" ] || [ "$source" == "--help" ]; then
        usage
        exit 1
    fi

    re='^[0-9]+$'
    if ! [[ "$select_count" =~ $re ]] ; then
        select_count=5
    fi

    wordcount=$(cat $source | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq | wc -l)

    if [ $wordcount -lt 1000 ]; then
        >&2 echo "Warning: source contains only $wordcount unique words"
    fi

    cat $source | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq \
       | shuf --random-source=/dev/random -n$select_count \
       | paste -s -d ' '
}
main $@
