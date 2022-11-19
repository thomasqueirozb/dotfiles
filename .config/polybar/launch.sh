#!/bin/bash

launch() {
    monitor="$1"

    if [ -n "$monitor" ]; then
        log_file="/tmp/polybar-$monitor.log"
        export MONITOR="$monitor"
    else
        log_file="/tmp/polybar.log"
    fi

    echo "---- LAUNCH ----" >> "$log_file"
    polybar --log=warning --reload bar >> "$log_file" 2>&1 & disown
    unset MONITOR
}


# Terminate already running bar instances
polybar-msg cmd quit

if command -v "xrandr" 1>/dev/null; then
    monitors=$(xrandr --query | grep " connected")
    main_monitor=$(echo "$monitors" | awk '/ connected primary/ {print $1}')

    launch "$main_monitor"

    sleep 1

    for monitor in $(echo "$monitors" | grep -v "$main_monitor" | awk '{print $1}'); do
        launch "$monitor"
    done
else
    launch
fi
