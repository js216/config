#!/usr/bin/env python

import sys
import string
import time
import datetime

if len(sys.argv) < 2:
    print("Usage: %s infile [outfile] [delimiter_char]" % sys.argv[0])
    sys.exit(1)

filename_in = sys.argv[1]

if len(sys.argv) > 2:
    filename_out = sys.argv[2]
    outfile = open(filename_out, 'w')
else:
    outfile = sys.stdout

delimiter = '\t'
if len(sys.argv) == 4:
    delimiter = sys.argv[3][0]
    print('using delimiter %c' % delimiter)

infile = open(filename_in, 'r')

letters = [
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
        'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB',
        'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AL', 'AM', 'AN',
        'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ',
        'BA', 'BB', 'BC', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI', 'BJ', 'BK', 'BL',
        'BM', 'BN', 'BO', 'BP', 'BQ', 'BR', 'BS', 'BT', 'BU', 'BV', 'BW', 'BX',
        'BY', 'BZ', 
        ]

text = ["# Produced by convert_csv_to_sc.py" ]

for row,line in enumerate(infile.readlines()):
    allp = line.rstrip().split(delimiter)
    if len(allp) > len(letters):
        print(f"i'm too simple to handle more than {len(letters)} columns")
        sys.exit(2)
    for column,p in enumerate(allp):
        col = letters[column]

        # empty cell
        if len(p) == 0:
            continue

        # date
        try:
            if p.count('/') == 2:
                date = datetime.datetime.strptime(p, "%m/%d/%Y")
                text.append('let %s%d = @dts(%d,%d,%d)' % (col, row, date.year, date.month, date.day))
                continue;
        except:
            pass

        # number
        try:
            n = float(p)
            text.append('let %s%d = %f' % (col, row, n))

        # text
        except:
            if p[0] == '"':
                text.append('label %s%d = %s' % (col, row, p))
            else:
                text.append('label %s%d = "%s"' % (col, row, p))

infile.close()
outfile.write("\n".join(text))
outfile.write("\n")
if outfile != sys.stdout:
    outfile.close()
