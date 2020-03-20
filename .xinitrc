#!/bin/sh

# set monitors
xrandr --output DVI-1-0 --auto
xrandr --output HDMI-1-1 --auto
xrandr --output DVI-1-0 -left-of DVI-0
xrandr --output HDMI-0 --right-of DVI-0
xrandr --output VGA-0 --left-of DVI-1-0
xrandr --output HDMI-1-1 --right-of HDMI-0
xrandr --output HDMI-1-1 --pos 6500x0
xrandr --output HDMI-0 --pos 4880x0
xrandr --output DVI-0 --pos 2960x0

# set background image
feh --bg-scale ~/.background.jpg

# map caps to esc
setxkbmap -option caps:escape

# status bar info
while true; do
   xsetroot -name "$( free | awk 'FNR == 2 {printf "%.0f%%",$3/$2*100}') $(cat /proc/loadavg|awk '{print $1" "$2" "$3" |"}'|sed 's/,//') $( sensors|grep "Core 0"|awk '{print $3}' ) $( sensors|grep "Core 1"|awk '{print $3}' ) $( sensors|grep "Core 2"|awk '{print $3}' ) $( sensors|grep "Core 3"|awk '{print $3}' ) $( sensors|grep "Core 4"|awk '{print $3}' ) $( sensors|grep "Core 5"|awk '{print $3" |"}' ) $( date +"%a %F %R" )" && sleep 30s
done &

exec dwm
