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

function kp() {
	PROCESS="$1"
	pgrep "$PROCESS" | xargs -r kill -9
	while pgrep "$PROCESS"; do
		sleep $SLEEP_TIME
	done
}

start_xrandr() {
	echo "Configuring monitors"
	# Configure monitors
	xrandr \
		--output DP-1 --auto --mode 1920x1080 --pos 0x0 \
		--output HDMI-1 --primary --mode 1920x1080 --right-of DP-1
}

start_xss() {
	echo "Starting: xss"
	# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
	# screen before suspend. Use loginctl lock-session to lock your screen.
	kp xss-lock
	xss-lock --transfer-sleep-lock -- i3lock --nofork &>/dev/null &
}

start_nm() {
	echo "Starting: nm-applet"
	kp nm-applet
	nm-applet &>/dev/null &
}

start_dex() {
	echo "Starting: dex"
	# https://wiki.archlinux.org/index.php/XDG_Autostart
	kp dex
	dex --autostart --environment i3
}

start_picom() {
	echo "Starting: picom"
	kp picom
	picom -f -b --config ~/.config/i3/picom.conf &
}

start_redshift() {
	echo "Starting: redshift"
	kp redshift
	redshift -m randr -x
	redshift -m randr -l 39.3627:-0.4120 &>/dev/null &
}

start_feh() {
	echo "Starting: feh"
	kp feh
	img=$(find "${HOME}/Imágenes/backgrounds/" -type f -name "*.jpg" | shuf -n 1)
	feh --bg-scale "$img" &
}

start_dunst() {
	echo "Starting: dunst"
	kp dunst
	dunst &
}

start_python_i3_scripts() {
	echo "Starting: python i3 scripts"
	python ~/.config/i3/scripts/autoname-workspaces.py &>/dev/null &
	python ~/.config/i3/scripts/autotiling.py &>/dev/null &
	python ~/.config/i3/scripts/inactive-windows-transparency.py &>/dev/null &
}

start_dunst
start_xrandr
start_xss
start_dex
start_picom
start_redshift
start_feh
start_python_i3_scripts
