set -o vi
export EDITOR=vim
bind -x '"\C-l": clear'

# history
shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history
export HISTTIMEFORMAT="[%F %T] "

# settings aliases
alias ls="ls --color"
alias watch="watch --color"
alias grep="grep --color"
alias less="less -R"
alias feh="feh --scale-down"
alias vi="busybox vi"

# abbreviating aliases
alias ac="apt-cache search"
alias aget="sudo apt install"
alias cal="ncal -b3"
alias dc="dc -f ~/.dcinit -"
alias RadioSuisse="mplayer http://stream.srg-ssr.ch/m/rsc_fr/mp3_128"
alias ognjisce="mplayer -ao jack http://real.ognjisce.si:8000/ognjisce.mp3"
alias Kindle="jmtpfs /media/kindle && mc ~/books/kindle /media/kindle/Internal\ Storage/documents"
alias UnKindle="sync && fusermount -u /media/kindle"
alias ShaMake="find . -type f -print0 | xargs -0 sha256sum"
alias Tor="cd ~/projects/prog/tor-browser && ./start-tor-browser.desktop"
alias ll="ls -lht"
alias ga="git add . && git status"
alias gc="git commit"
alias gs="git status"
alias Ljubljana='TZ=Europe/Ljubljana date "+%Y-%m-%d %H:%M %Z"'
alias UTC='TZ=UTC date "+%Y-%m-%d %H:%M %Z"'

function pdf-extract() {
   /usr/bin/gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=$3 -dLastPage=$4 -sOutputFile=$2 $1
} # usage: pdf-extract input.pdf output.pdf <firstPage> <lastPage>

g() {
    w3m "https://duckduckgo.com/?q=$(printf '%s\n' "$*" | sed 's/ /+/g')"
}

. "$HOME/.cargo/env"
export PATH=/opt/llvm22/bin:$PATH
