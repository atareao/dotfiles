#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Copyright (c) 2022 Lorenzo Carbonell <a.k.a. atareao>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

SLEEP_TIME=0.01

function kp(){
    PROCESS="$1"
    pgrep "$PROCESS" | xargs -r kill -9
    while pgrep "$PROCESS";do
        sleep $SLEEP_TIME
    done
}

function init_rofi(){
    MON_NAME=$(python ~/.config/i3/scripts/get_current_monitor.py)
    if [[ "${MON_NAME}" == "DisplayPort-0" ]]
    then
        MONITOR=0
    else
        MONITOR=1
    fi
    rofi -monitor "${MONITOR}" \
         -combi-modi drun,window,ssh \
         -show combi \
         -modi combi \
         -matching fuzzy
}

kp rofi
init_rofi
