fname=/home/jk/temp/aaa-$(date +%s).png
import $fname
xclip -selection clipboard -t image/png -i $fname
