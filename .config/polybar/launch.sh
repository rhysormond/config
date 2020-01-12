#!/usr/bin/env bash

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar
polybar i3-bar &

# hide the bar on launch
sleep 1 && polybar-msg cmd toggle
