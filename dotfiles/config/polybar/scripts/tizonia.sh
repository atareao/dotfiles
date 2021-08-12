#!/usr/bin/env bash
#-*- coding: utf-8 -*-

# Copyright (c) 2021 Lorenzo Carbonell <a.k.a. atareao>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

ans=$(tizonia-remote playstatus 2>/dev/null)
if [ -z $ans ]
then
    command="tizonia --shuffle --youtube-audio-mix-search 'chopin' -d"
    echo "%{T4}%{A1:$command:}󰽴󰐊 %{A}%{T-}"
elif [ $ans = "\"Playing\"" ]
then
    echo "%{T4}%{A1:tizonia-remote prev:}󰒮%{A}%{A1:tizonia-remote pause:}󰏤%{A}%{A1:tizonia-remote quit:}󰓛%{A}%{A1:tizonia-remote next:}󰒭%{A}%{T-}"
elif [ $ans = "\"Paused\"" ]
then
    echo "%{T4}%{A1:tizonia-remote prev:}󰒮%{A}%{A1:tizonia-remote play:}󰐊 %{A}%{A1:tizonia-remote quit:}󰓛%{A}%{A1:tizonia-remote next:}󰒭%{A}%{T-}"
fi
