#!/bin/bash
# TAR INVOKED SCRIPT

# remove temporary file
rm $TAR_ARCHIVE

# get volume number
n=$(</tmp/backup/number)

# check archive exists
if [[ ! -f /media/$TAR_BACKUP_DRIVE/$TAR_BACKUP_SUBDIR/$n.tar.gz.gpg ]] 
then
   >&2 echo "ERROR: Archive $n does not exist."
   exit -1
fi

# copy next archive from flash drive
cp /media/$TAR_BACKUP_DRIVE/$TAR_BACKUP_SUBDIR/$n.tar.gz.gpg /tmp/backup/$n.tar.gz.gpg 

# decrypt
gpg --quiet -d --batch \
   --passphrase-file ~/.prog/backup_passwd.txt \
   --output /tmp/backup/$n.tar.gz \
   "/tmp/backup/$n.tar.gz.gpg"

# remove temporary file
rm /tmp/backup/$n.tar.gz.gpg

# decompress
gunzip /tmp/backup/$n.tar.gz

# move to location where tar expects archive
mv /tmp/backup/$n.tar $TAR_ARCHIVE

# list filenames with volume number
tar tf "$TAR_ARCHIVE" 2> >(grep -v -e 'Unexpected EOF in archive' \
                                  -e 'Error is not recoverable: exiting now' >&2) \
| sed "s|^|Volume $n: |" >> ~/temp/backup_files.txt

# increment volume number
echo $((n+1)) >/tmp/backup/number
