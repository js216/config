#!/bin/sh
#
# ~/.xinitrc
#

/usr/bin/feh --bg-fill /home/jk/.bg.jpg

while true; do
   xsetroot -name "\
       $( acpi -V|head -n 1|awk '{print $4" "$5}'|sed 's/,//' ) $( free | awk 'FNR == 2 {printf "%.0f%%",$3/$2*100}') $(cat /proc/loadavg|awk '{print $2}'|sed 's/,//') $( date +"%a %F %R" )" && sleep 10s
   xkbset m
done &

xmodmap -e "keycode 9 = Caps_Lock"
xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'

xkbset m
xmodmap -e "keycode 108 = Pointer_Button1"
xmodmap -e "keycode 135 = Pointer_Button2"
xmodmap -e "keycode 105 = Pointer_Button3"

# to make arduino work
_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

exec /usr/local/bin/dwm
