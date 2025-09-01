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

# move up
echo up

# get the column of current cell and convert to letter (0 -> A, ...)
echo eval @mycol
read COL
COL_LETTER=$(col_to_letters "$COL")

# get row of current cell
echo eval @myrow
read ROW

# copy trick: erase and pull
echo erase $COL_LETTER$ROW
echo pull

# come back down
echo down

# pull the value here also
echo pull

# move cursor once cell right
echo mright
