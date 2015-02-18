#!/bin/sh

setxkbmap -layout vok_sk
xrdb -load ~/.Xresources
xset +dpms
xset dpms 500 1000 1500
xset r rate 250  50
eval `ssh-agent`
#xrandr --output LVDS1 --mode 1600x900
xsetroot -cursor_name left_ptr
#eval $(gpg-agent --daemon)
xscreensaver &> /dev/null &

#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad
xmonad
