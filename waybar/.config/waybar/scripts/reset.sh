#!/bin/bash

killall waybar

while pgrep -u $UID -x waybar >/dev/null; do sleep 0.5; done
sleep 0.5

waybar&

