#!/bin/sh

WIDTH=270
HEIGHT=274
BOTTOM=false
DATE="$(date +" %a, %b %d @ %I:%M %p ")"

case "$1" in
    --popup)

	yad --calendar --undecorated --gtk-palette --fixed --close-on-unfocus --no-buttons \
       --posx=3215 --posy=31  --title="calendar" --borders=0 >/dev/null &

        ;;
    *)
        echo "$DATE"
        ;;
esac
