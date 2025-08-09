#!/bin/bash

# get the column of current cell and convert to letter (0 -> A, ...)
echo eval @mycol
read COL
COL_LETTER=$(printf "\\$(printf '%03o' $((COL + 65)))")

# get row of current cell
echo eval @myrow
read ROW

# get value of current cell
echo getnum
read VAL

# return the negated value
if [[ $VAL =~ [0-9] ]]; then
   echo let $COL_LETTER$ROW = -$VAL
fi

# move cursor once cell right
echo mright
