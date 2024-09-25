#! /bin/sh

# terminate all existing bar instances
killall -q polybar

# wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar

polybar main & 
if [[ $(xrandr -q | grep 'DisplayPort-1 connected') ]]; then
    polybar offset_monitor &
fi
