#!/bin/bash

# Verifica si waybar está corriendo
if pgrep -x "waybar" > /dev/null; then
    # Si está corriendo, lo terminamos
    killall waybar
    notify-send "Waybar" "Waybar ha sido cerrado"
else
    # Si no está corriendo, lo iniciamos
    waybar &
    notify-send "Waybar" "Waybar ha sido iniciado"
fi
