set -o vi
export EDITOR=vim
bind -x '"\C-l": clear'
source ~/.prog/backup.sh

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
alias vi="busybox vi"
alias info="info --vi-keys"

# abbreviating aliases
alias ac="apt-cache search"
alias aget="sudo apt install"
alias cal="ncal -b3"
alias dc="dc -f ~/.dcinit -"
alias RadioSuisse="mplayer http://stream.srg-ssr.ch/m/rsc_fr/mp3_128"
alias ognjisce="mplayer -ao jack http://real.ognjisce.si:8000/ognjisce.mp3"
alias AllDayCalEvent="gcalcli add --allday --where '' --duration 1 --description ''"
alias Record="pw-record - | lame -r -s 48 - $(date +%d%b%y).mp3"
alias Kindle="jmtpfs /media/kindle && mc ~/books/kindle /media/kindle/Internal\ Storage/documents"
alias UnKindle="sync && fusermount -u /media/kindle"

function g() {
   w3m -no-cookie "http://www.google.com/search?q=$(echo $@ | sed 's/ /+/g' )"
}

function pdf-extract() {
   gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=$3 -dLastPage=$4 -sOutputFile=$2 $1
} # usage: pdf-extract input.pdf output.pdf <firstPage> <lastPage>

function Bells()
{
   while true
   do
      timeout $1 cat
      timeout 0.5 speaker-test -t sine -f 400 -l 1 -p 1 2&> /dev/null
      timeout $2 cat
      timeout 0.5 speaker-test -t sine -f 600 -l 1 -p 1 2&> /dev/null
      timeout $3 cat
      timeout 0.5 speaker-test -t sine -f 800 -l 1 -p 1 2&> /dev/null
   done
}
. "$HOME/.cargo/env"
