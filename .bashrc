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

# abbreviating aliases
alias ac="apt-cache search"
alias aget="sudo apt install"
alias RadioSuisse="mplayer http://stream.srg-ssr.ch/m/rsc_fr/mp3_128"
alias ognjisce="mplayer -ao jack http://real.ognjisce.si:8000/ognjisce.mp3"
alias AllDayCalEvent="gcalcli add --allday --where '' --duration 1 --description ''"

function g() {
   w3m -no-cookie "http://www.google.com/search?q=$(echo $@ | sed 's/ /+/g' )"
}

function pdf-extract() {
   gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=$3 -dLastPage=$4 -sOutputFile=$2 $1
} # usage: pdf-extract input.pdf output.pdf <firstPage> <lastPage>
