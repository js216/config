#!/bin/bash

# Basic snapshot-style rsync backup script 

# Config
OPT="-aPh --exclude=.prog/vmware"
LINK="--link-dest=/mnt/backup/jk/last/" 
SRC="/home/jk/"
SNAP="/mnt/backup/jk/"
LAST="/mnt/backup/jk/last"
date=`date "+%Y-%b-%d:_%T"`

# Run rsync to create snapshot
rsync $OPT $LINK $SRC ${SNAP}$date >> $SNAP/rsync.log

# Remove symlink to previous snapshot
rm -f $LAST

# Create new symlink to latest snapshot for the next backup to hardlink
ln -s ${SNAP}$date $LAST

# record disk space, and finishing time
df -h >> $SNAP/rsync.log
date  >> $SNAP/rsync.log
