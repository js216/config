#!/usr/bin/env python3
"""
Merge or unmerge bash "eternal history" files that use HISTTIMEFORMAT
timestamps of the form:

    #<epoch>
    command

This tool safely embeds origin metadata on the timestamp line:

    #<epoch> @origin

Default mode (merge):
  - Reads one or more history files given as positional arguments
  - Annotates each entry with its source filename as origin
  - Merges all entries chronologically
  - Writes merged history to stdout

Unmerge mode:
  - Activated with -u / --unmerge
  - Takes exactly one input file
  - Splits history into per-origin files
  - Refuses to overwrite existing files
  - Entries without origin go to: history.txt

Usage:
  Merge:
    merge_bash_history.py hist1 hist2 > merged_history

  Unmerge:
    merge_bash_history.py --unmerge merged_history

Copyright (c) 2026 Jakob Kastelic
"""

import argparse
import os
import sys
import re
from collections import defaultdict

TIMESTAMP_RE = re.compile(r'^#([0-9]+)(?:\s+@(.+))?$')


def die(msg):
    print(f"error: {msg}", file=sys.stderr)
    sys.exit(1)


def check_files_exist(files):
    for f in files:
        if not os.path.isfile(f):
            die(f"file does not exist: {f}")


def merge(files):
    records = []

    for filename in files:
        with open(filename, 'r', encoding='utf-8', errors='replace') as fh:
            ts = None
            for line in fh:
                line = line.rstrip('\n')

                m = TIMESTAMP_RE.match(line)
                if m:
                    ts = m.group(1)
                    continue

                if ts is None:
                    # command without timestamp: ignore silently
                    continue

                records.append((int(ts), filename, line))
                ts = None

    records.sort(key=lambda r: r[0])

    out = sys.stdout
    for ts, origin, cmd in records:
        out.write(f"#{ts} @{origin}\n")
        out.write(f"{cmd}\n")


def unmerge(filename):
    outputs = defaultdict(list)

    with open(filename, 'r', encoding='utf-8', errors='replace') as fh:
        ts_line = None
        origin = None

        for line in fh:
            line = line.rstrip('\n')

            m = TIMESTAMP_RE.match(line)
            if m:
                ts_line = f"#{m.group(1)}"
                origin = m.group(2)
                continue

            if ts_line is None:
                continue

            target = origin if origin else "history.txt"
            outputs[target].append(ts_line)
            outputs[target].append(line)

            ts_line = None
            origin = None

    # Check for overwrite risk
    for outname in outputs:
        if os.path.exists(outname):
            die(f"refusing to overwrite existing file: {outname}")

    # Write outputs
    for outname, lines in outputs.items():
        with open(outname, 'w', encoding='utf-8') as fh:
            for l in lines:
                fh.write(l + "\n")


def main():
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument(
        "-u", "--unmerge",
        action="store_true",
        help="unmerge a previously merged history file"
    )
    parser.add_argument("files", nargs="+")

    args = parser.parse_args()

    check_files_exist(args.files)

    if args.unmerge:
        if len(args.files) != 1:
            die("--unmerge requires exactly one filename")
        unmerge(args.files[0])
    else:
        merge(args.files)


if __name__ == "__main__":
    main()
