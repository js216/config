setxkbmap $1
xkbset m;
xkbset exp =m;
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape';
xmodmap -e "keycode 108 = Pointer_Button1"
xmodmap -e "keycode 135 = Pointer_Button2"
xmodmap -e "keycode 105 = Pointer_Button3"
xmodmap -e "keycode 29 = y"
xmodmap -e "keycode 52 = z"
