#!/bin/sh

uid=$(id -u)

# Terminate already running bar instances
pgrep polybar || sleep 3
killall -q polybar -u "$USER"

# Wait until the processes have been shut down
while pgrep -u "$uid" -x polybar >/dev/null; do sleep 1; done

if command -v "xrandr" 1>/dev/null; then
    monitors=$(xrandr --query | grep " connected")
    main_monitor=$(echo "$monitors" | awk '/ connected primary/ {print $1}')
    MONITOR=$main_monitor polybar -c ~/.config/polybar/config --reload bar &
    sleep 1

    for m in $(echo "$monitors" | grep -v "$main_monitor" | awk '{print $1}'); do
        MONITOR=$m polybar -c ~/.config/polybar/config --reload bar &
    done
else
    polybar -c ~/.config/polybar/config --reload bar &
fi
