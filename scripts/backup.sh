Backup() {
    # Choose a subdirectory
    subdir="${2:-home-backup}"

    # check the target directory exists
    if [ ! -d "/media/$1/$subdir" ] 
    then
        echo "ERROR: Directory /media/$1/$subdir does not exists."
        return -1
    fi

    # determine mode of operation
    if [[ $subdir = "copy" ]]
    then
        flags="-avhc --delete"
    elif [[ $subdir = "test" ]]
    then
        flags="-avhcn --delete"
    else
        echo "ERROR: Unknown command."
        return -1
    fi

    # copy or verify the files
    time rsync $flags \
        --exclude=/music \
        /home/jk/ /media/$1/$subdir > backup-$1.log
}

TarBackup() {
    # Choose a subdirectory
    subdir="${2:-home-backup}"

    # check the target directory exists
    if [ ! -d "/media/$1/$subdir" ] 
    then
        >&2 echo "ERROR: Directory /media/$1/$subdir does not exists."
        return -1
    fi

    # check there are no previous temporary files left over (indicing errors)
    if [[ -d /tmp/backup ]] 
    then
        >&2 echo "ERROR: Temporary files left over."
        return -1
    fi

    # save on file the initial volume number
    mkdir /tmp/backup
    echo 1 >/tmp/backup/number

    # run tar create
    cd ~
    export TAR_BACKUP_DRIVE="$1"
    export TAR_BACKUP_SUBDIR="$2"
    time tar cv -L 512M -F ~/.prog/tar_compress.sh -f /tmp/backup/$1 \
       --exclude=*.swp \
       --exclude=temp \
       --exclude=music \
       --exclude=movies \
       --exclude=.cache \
       --exclude=.cargo \
       --exclude=.config \
       --exclude=.mpd \
       --exclude=.downloads \
       --exclude=.uml \
       --exclude=.local \
       -C/ \
       home/jk 2>&1 > /tmp/backup/backup.txt | \
       grep -v ": file name too long to be stored in a GNU multivolume header"

    # execute the "change-volume" script a last time
    ~/.prog/tar_compress.sh /tmp/backup/$1

    # remove temp files
    rm /tmp/backup/number
    rm /tmp/backup/backup.txt
    rm -d /tmp/backup
}

TarCompare() {
    # Choose a subdirectory
    subdir="${2:-home-backup}"

    # check the target directory exists
    if [ ! -d "/media/$1/$subdir" ] 
    then
        >&2 echo "ERROR: Directory /media/$1/$subdir does not exists."
        return -1
    fi

    # check there are no previous temporary files left over (indicing errors)
    if [[ -d /tmp/backup ]] 
    then
        >&2 echo "ERROR: Temporary files left over."
        return -1
    fi

    # save on file the initial volume number
    mkdir /tmp/backup
    echo 1 >/tmp/backup/number

    # clear previous output
    > ~/temp/backup_files.txt

    # setup temp files
    cd ~
    touch /tmp/backup/$1

    # run tar diff
    export TAR_BACKUP_DRIVE="$1"
    export TAR_BACKUP_SUBDIR="$2"
    time tar dv  --ignore-zeros -F ~/.prog/tar_decompress.sh -f /tmp/backup/$1 -C/ \
       2>&1 > /tmp/compare.txt | \
       grep -v "is possibly continued on this volume: header contains truncated name"

    # remove temp files
    rm /tmp/backup/number
    rm -d /tmp/backup
}

MusicBackup() {
    # check the target directory exists
    if [ ! -d "/media/$1/music" ] 
    then
        echo "ERROR: Directory /media/$1/music does not exists."
        return -1
    fi

    # determine mode of operation
    if [[ $2 = "copy" ]]
    then
        flags="-avhc --delete"
    elif [[ $2 = "test" ]]
    then
        flags="-avhcn --delete"
    else
        echo "ERROR: Unknown command."
        return -1
    fi

    # copy or verify the files
    time rsync $flags /home/jk/music/ /media/$1/music > temp/musicbackup-$1.log
}
