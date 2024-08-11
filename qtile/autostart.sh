#!/bin/bash

xrandr --output HDMI-0 --mode 1920x1080 --rate 75 --pos 0x0 --rotate normal --output DP-0 --primary --mode 1920x1080 --rate 165 --pos 1920x0 --rotate normal 

#starting utility applications at boot time
dunst &
variety &
pasystray &
# numlockx on &
blueman-applet &
# /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
picom --config $HOME/.config/qtile/scripts/picom.conf &
# /usr/lib/xfce4/notifyd/xfce4-notifyd &
