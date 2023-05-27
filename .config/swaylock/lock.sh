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

original_dir="$(pwd)"

cd "$(dirname "$0")" || exit

grim -t jpeg screen.jpg

#get logo path, if none random
if [[ "$2" != "" ]]; then
  cd "$original_dir" || exit
  image=$(realpath "$2")
  cd "$(dirname "$0")" || exit
else
  image="icons/$(shuf -i0-2 -n1).png"
fi


#make background image
rm logo-ed_screen.png

# this command is crazy fast, but it gaussian blurs and overlays a logo
# with a speed that is around 3-4 times faster than the time it takes for
# imagemagick to simply composite that logo (no blurring)
# (test is not done in a controlled environment, but you get the idea)
# I FUCKING LOVE FFMPEG!!
ffmpeg -i screen.jpg -vf \
  "[in] gblur=sigma=$1  [blurred]; movie=$image [logo];
  [blurred][logo] overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2 [out]" \
  logo-ed_screen.png

#import pywal colors
# shellcheck source=/home/master/.cache/wal/colors.sh
#source "$HOME/.cache/wal/colors.sh"

BACKGROUND='#89C4C2'
KEY_COLOR='#D0EBC5'
HL_COLOR='#F3F7C1'
VER_COLOR='#F9D4A4'
CLEAR_COLOR='#F5A2A2'
WRONG_COLOR='#BC789E'


swaylock \
  --image "$HOME/.config/swaylock/logo-ed_screen.png" \
  --daemonize \
  --indicator-radius 160 \
  --indicator-thickness 20 \
  --inside-color 00000000 \
  --inside-clear-color 00000000 \
  --inside-ver-color 00000000 \
  --inside-wrong-color 00000000 \
  --key-hl-color "$KEY_COLOR" \
  --bs-hl-color "$HL_COLOR" \
  --ring-color "$BACKGROUND" \
  --ring-clear-color "$CLEAR_COLOR" \
  --ring-wrong-color "$WRONG_COLOR" \
  --ring-ver-color "$VER_COLOR" \
  --line-uses-ring \
  --line-color 00000000 \
  --font 'NotoSans Nerd Font Mono:style=Thin,Regular 40' \
  --text-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --text-ver-color 00000000 \
  --separator-color 00000000 \



