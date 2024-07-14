#!/bin/bash
# TAR INVOKED SCRIPT

# compress
gzip /tmp/backup.tar

# encrypt
gpg -c --cipher-algo AES --batch --output /tmp/backup.tar.gz.gpg \
   --passphrase "radar jelly trustful sherry" /tmp/backup.tar.gz

# remove temporary file
rm /tmp/backup.tar.gz

# move to flash drive
FNAME=$(date +%d%b%y).tar.$(($TAR_VOLUME-1)).gz.gpg
mv /tmp/backup.tar.gz.gpg /media/sdd1/home-backup/$FNAME
