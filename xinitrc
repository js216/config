#!/bin/sh
#
# ~/.xinitrc
#

# set desktop background
/usr/bin/feh --bg-fill /home/jk/slike/1418047280-bg.jpg

# status bar for dwm
while true; do
   xsetroot -name "\
       $( acpi -V|head -n 1|awk '{print $4" "$5}'|sed 's/,//' ) $( free | awk 'FNR == 2 {printf "%.0f%%",$3/$2*100}') $(cat /proc/loadavg|awk '{print $2}'|sed 's/,//') $( date +"%a %F %R" )" && sleep 10s
   xkbset m
done &

# remap some keyboard keys
xkbset m
xmodmap -e "keycode 9 = Caps_Lock"
xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'
xmodmap -e "keycode 108 = Pointer_Button1"
xmodmap -e "keycode 135 = Pointer_Button2"
xmodmap -e "keycode 105 = Pointer_Button3"

# to make arduino work
_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

# conky for status display
/usr/bin/conky &

exec /usr/local/bin/dwm
