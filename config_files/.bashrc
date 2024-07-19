set -o vi
export EDITOR=vim
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/jk/.local/bin"
export GOPATH=$HOME/.local/go
bind -x '"\C-l": clear'

# history
shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history
export HISTTIMEFORMAT="[%F %T] "

# settings aliases
alias octave="octave -q --no-gui"
alias bc="bc -lq"
alias ls="ls --color"
alias watch="watch --color"
alias grep="grep --color"
alias less="less -R"
alias feh="feh --scale-down"
alias agg="ag -C 5 --pager='less -R'"
alias du="du -B1"

# abbreviating aliases
alias archive="/home/jk/.prog/Archive.sh"
alias ac="apt-cache search"
alias aget="sudo apt install"
alias concordance="tr -d '[:punct:]' | tr ' ' '\n' | tr 'A-Z' 'a-z' | sort | uniq -c | sort -rn"
alias EscCaps="echo keycode 1 = Caps_Lock | sudo loadkeys - && echo keycode 58 = Escape | sudo loadkeys -"
alias WiFiOff="sudo iwconfig wlan0 txpower off"
alias WiFiOn="sudo iwconfig wlan0 txpower auto"
alias RadioSuisse="mplayer http://stream.srg-ssr.ch/m/rsc_fr/mp3_128"
alias ognjisce="mplayer -ao jack http://real.ognjisce.si:8000/ognjisce.mp3"
alias am="alsamixer -c 0"
alias md5="time find -type f \( -not -name "md5sum.txt" \) -exec md5sum '{}' \; > md5sum.txt"

function g() {
   w3m -no-cookie "http://www.google.com/search?q=$(echo $@ | sed 's/ /+/g' )"
}

function pdf-extract() {
   gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=$3 -dLastPage=$4 -sOutputFile=$2 $1
} # usage: pdf-extract input.pdf output.pdf <firstPage> <lastPage>

function WifiConnect() {
   if [ -z $2 ]
   then
      sudo nmcli device wifi connect $1
   else
      sudo nmcli device wifi connect $1 password $2
   fi
}

function brightness() {
   echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
}

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
    time tar c -L 512M -F ~/.prog/tar_compress.sh -f $1 \
       --exclude=$1 \
       --exclude=temp \
       --exclude=music \
       --exclude=movies \
       --exclude=.cache \
       --exclude=.config \
       --exclude=.mpd \
       --exclude=.downloads \
       --exclude=.local \
       -C/ \
       home/jk

    # execute the "change-volume" script a last time
    ~/.prog/tar_compress.sh $1

    # remove temp files
    rm /tmp/backup/number
    rm -d /tmp/backup
}

TarCompare() {
    # check there are no previous temporary files left over (indicing errors)
    if [[ -d /tmp/backup.tar ]] 
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
