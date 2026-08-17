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

# get today's date components
read YEAR MONTH DAY < <(date +"%Y %-m %-d")

# insert into current cell as an @dts date value
echo let $COL_LETTER$ROW = @dts\($YEAR,$MONTH,$DAY\)

# apply date display format
#printf 'fmt %s "\004%%m/%%d/%%y"\n' "$COL_LETTER$ROW"

# move cursor once cell right
echo right
