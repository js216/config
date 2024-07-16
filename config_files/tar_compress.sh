#!/bin/bash
# TAR INVOKED SCRIPT

# get volume number
n=$(</tmp/backup-number)

if [ -z "${TAR_ARCHIVE}" ]
then
   TAR_ARCHIVE=$1
fi

# move file to temp
mv $TAR_ARCHIVE /tmp/backup.tar

# compress
gzip /tmp/backup.tar

# encrypt
gpg -c --cipher-algo AES --batch --output /tmp/backup.tar.gz.gpg \
   --passphrase "radar jelly trustful sherry" /tmp/backup.tar.gz

# remove temporary file
rm /tmp/backup.tar.gz

# move to flash drive
mv /tmp/backup.tar.gz.gpg /media/$TAR_ARCHIVE/home-backup/$n.tar.gz.gpg

# increment volume number
echo $((n+1)) >/tmp/backup-number
