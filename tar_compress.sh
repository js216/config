#!/bin/bash
# TAR INVOKED SCRIPT

# get volume number
n=$(</tmp/backup/number)

if [ -z "${TAR_ARCHIVE}" ]
then
   TAR_ARCHIVE=$1
fi

# move file to temp
mv $TAR_ARCHIVE /tmp/backup/backup.tar

# compress
gzip /tmp/backup/backup.tar

# encrypt
gpg -c --cipher-algo AES --batch --output /tmp/backup/backup.tar.gz.gpg \
   --passphrase "$(< backup_passwd.txt)" /tmp/backup/backup.tar.gz

# remove temporary file
rm /tmp/backup/backup.tar.gz

# move to flash drive
mv /tmp/backup/backup.tar.gz.gpg /media/$TAR_ARCHIVE/home-backup/$n.tar.gz.gpg

# increment volume number
echo $((n+1)) >/tmp/backup/number
