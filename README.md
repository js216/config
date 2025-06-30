# Configuration files and useful scripts

This repository contains my configuration files for command-line utilities and
some useful potentially scripts. The "dot files" normally residing in the home
directory have their dots removed here.

- `backup.sh` implements simple backup functions `Backup()`, `TarBackup()`, and
  `TarCompare()` to copy files with rsync, or to put them in fixed-size tar
  archives, compressed and encrypted.

- `mc`: Keymap is changed to allow vi-like motion with hjkl keys, and going to
  top/bottom of the file list with g/G. The theme is changed to dark mode
  (rather than the usual bright blue), and the command line hidden (since it's
  easy enough to switch to full-screen terminal and back again with Ctrl-O).
