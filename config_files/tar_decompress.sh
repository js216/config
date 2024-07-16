#!/bin/bash
# TAR INVOKED SCRIPT

# remove temporary file
rm $TAR_ARCHIVE

# get volume number
n=$(</tmp/backup-number)

# check archive exists
if [[ ! -f /media/$TAR_ARCHIVE/home-backup/$n.tar.gz.gpg ]] 
then
   >&2 echo "ERROR: Archive $n does not exist."
   exit -1
fi

# copy next archive from flash drive
cp /media/$TAR_ARCHIVE/home-backup/$n.tar.gz.gpg /tmp/backup.tar.gz.gpg 

# decrypt
gpg -d --quiet --batch --output /tmp/backup.tar.gz \
   --passphrase "radar jelly trustful sherry" /tmp/backup.tar.gz.gpg

# remove temporary file
rm /tmp/backup.tar.gz.gpg

# decompress
gunzip /tmp/backup.tar.gz

# move to location where tar expects archive
mv /tmp/backup.tar $TAR_ARCHIVE

# increment volume number
echo $((n+1)) >/tmp/backup-number
