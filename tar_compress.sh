#!/bin/bash
# TAR INVOKED SCRIPT

# get volume number
n=$(</tmp/backup/number)

# if TAR_ARCHIVE undefined, take it from cmdline arg
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
   --passphrase "$(< ~/.prog/backup_passwd.txt)" /tmp/backup/backup.tar.gz

# remove temporary file
rm /tmp/backup/backup.tar.gz

# move to flash drive
mv /tmp/backup/backup.tar.gz.gpg \
   /media/$TAR_BACKUP_DRIVE/$TAR_BACKUP_SUBDIR/$n.tar.gz.gpg

# append SHA256 checksum to central file
cd /media/$TAR_BACKUP_DRIVE/$TAR_BACKUP_SUBDIR
sha256sum $n.tar.gz.gpg >> volumes.sha256
cd -

# increment volume number
echo $((n+1)) >/tmp/backup/number
