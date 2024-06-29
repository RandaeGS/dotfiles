#!/bin/bash

##changed via give-me-azerty-qtile
#setxkbmap be
xrandr --output HDMI-0 --mode 1920x1080 --rate 75 --pos 0x0 --rotate normal --output DP-0 --primary --mode 1920x1080 --rate 165 --pos 1920x0 --rotate normal 

#starting utility applications at boot time
run variety &
run nm-applet &
#run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/qtile/scripts/picom.conf &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
run volumeicon &
