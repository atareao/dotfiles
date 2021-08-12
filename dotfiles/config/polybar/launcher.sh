#!/usr/bin/env bash

# Only if you want debug
DEBUG=1

killall -q polybar

if [ $DEBUG -eq 1 ]
then
    echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    polybar bar1 > /tmp/polybar1.log 2>&1 & disown
    polybar bar2 > /tmp/polybar2.log 2>&1 & disown
else
    polybar bar1 >/dev/null 2>&1 & disown
    polybar bar2 >/dev/null 2>&1 & disown
fi
echo "Bars launched..."
