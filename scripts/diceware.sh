#!/bin/sh

usage() {
    echo "diceware.sh - a tool to select random words from a source, to generate a strong passphrase"
    echo ""
    echo "Usage:"
    echo "dice.sh /path/to/source/text [selection_count]"
    echo "  /path/to/source/text - mandatory filepath to source text file"
    echo "  selection_count - optional, number of random words to select from source, defaults to 5"
}

main() {
    source=$1
    select_count=$2

    if [ -z "$source" ] || [ "$source" = "-h" ] || [ "$source" = "--help" ]; then
        usage
        exit 1
    fi

    # Default selection count
    case "$select_count" in
        ''|*[!0-9]*)
            select_count=5
            ;;
    esac

    # Count unique words
    wordcount=$(cat "$source" | tr -cs 'A-Za-z' '\n' | tr 'A-Z' 'a-z' | sort | uniq | wc -l)

    if [ "$wordcount" -lt 1000 ]; then
        echo "Warning: source contains only $wordcount unique words" 1>&2
    fi

    # Generate passphrase
    cat "$source" | \
        tr -cs 'A-Za-z' '\n' | \
        tr 'A-Z' 'a-z' | \
        sort | uniq | \
        awk -v n="$select_count" 'BEGIN {srand()} {a[NR]=$0} END {for(i=1;i<=n;i++){x=int(1+rand()*NR); printf "%s%s", a[x], (i<n?" ":"\n")}}'
}

main "$@"
