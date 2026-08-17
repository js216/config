#!/bin/bash

col_to_letters() {
    local n=$1
    local result=""
    while (( n >= 0 )); do
        local letter=$(( n % 26 ))
        result="$(printf \\$(printf '%03o' $((letter + 65))))$result"
        n=$(( n / 26 - 1 ))
    done
    echo "$result"
}

# get the column of current cell and convert to letter (0 -> A, ...)
echo eval @mycol
read COL
COL_LETTER=$(col_to_letters "$COL")

# get row of current cell
echo eval @myrow
read ROW

# get current time as H:MM or HH:MM (24h, no leading zero on hours)
NOW=$(date +"%-H:%M")

# insert as a centered label string
echo label $COL_LETTER$ROW = \"$NOW\"

# move cursor once cell left
echo left
