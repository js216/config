Backup() {
    # check the target directory exists
    if [ ! -d "/media/$1/home-backup" ] 
    then
        echo "ERROR: Directory /media/$1/home-backup does not exists."
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
    time rsync $flags \
        --exclude=/music \
        --exclude=/movies \
        --exclude=/.cache \
        --exclude=/.config \
        --exclude=/.downloads \
        --exclude=/.local \
        /home/jk/ /media/$1/home-backup > backup-$1.log
}

TarBackup() {
    # check the target directory exists
    if [ ! -d "/media/$1/home-backup" ] 
    then
        >&2 echo "ERROR: Directory /media/$1/home-backup does not exists."
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
    time tar cv -L 512M -F ~/.prog/tar_compress.sh -f $1 \
       --exclude=*.swp \
       --exclude=$1 \
       --exclude=temp \
       --exclude=music \
       --exclude=movies \
       --exclude=.cache \
       --exclude=.config \
       --exclude=.mpd \
       --exclude=.downloads \
       --exclude=.uml \
       --exclude=.local \
       -C/ \
       home/jk 2>&1 > /tmp/backup_files.txt | \
       grep -v ": file name too long to be stored in a GNU multivolume header"

    # execute the "change-volume" script a last time
    ~/.prog/tar_compress.sh $1

    # remove temp files
    rm /tmp/backup/number
    rm -d /tmp/backup
}

TarCompare() {
    # check the target directory exists
    if [ ! -d "/media/$1/home-backup" ] 
    then
        >&2 echo "ERROR: Directory /media/$1/home-backup does not exists."
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

    # setup temp files
    cd ~
    touch $1

    # run tar diff
    time tar dv -F ~/.prog/tar_decompress.sh -f $1 -C/

    # remove temp files
    rm $1
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
    time rsync $flags /home/jk/music/ /media/$1/music > musicbackup-$1.log
}
