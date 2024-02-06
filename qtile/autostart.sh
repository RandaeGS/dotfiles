#!/bin/sh
# Screen layout #
xrandr --output HDMI-0 --mode 1920x1080 --rate 75 --pos 0x0 --rotate normal --output DP-0 --primary --mode 1920x1080 --rate 165 --pos 1920x0 --rotate normal 

# Random wallpaper #
wal -s -i ~/Pictures/wallpapers

dunst
