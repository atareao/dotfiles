#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Copyright (c) 2021 Lorenzo Carbonell <a.k.a. atareao>

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

strindex() {
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

mybuilder() {
    KEY={{@@ env['KEY'] @@}}
    PPA="atareao/test"
    MAIN_DIR=$PWD
    DEBIAN_DIR=$PWD'/debian'
    SRCDIR=$PWD'/src'
    if [ -d $SCRDIR ]
    then
        echo 'This is a GNOME Shell extension'
        SRCDIR=$PWD/${PWD##*/}
    fi
    LOCALE=$PWD'/locale'
    CHANGELOG=$PWD'/debian/changelog'
    PARENDIR="$(dirname "$MAIN_DIR")"
    PYCACHEDIR=$SRCDIR'/__pycache__'
    if [ -d $PYCACHEDIR ]; then
        echo '====================================='
        echo "Removing cache directory: $PYCACHEDIR"
        rm -rf $PYCACHEDIR
    fi
    if [ -d $LOCALE ]; then
        echo '====================================='
        echo "Removing locale directory: $LOCALE"
        rm -rf $LOCALE
    fi
    firstline=$(head -n 1 $CHANGELOG)
    pos=$(strindex "$firstline" "(")
    posf=$(strindex "$firstline" ")")
    app=${firstline:0:$pos-1}
    app=${app,,} #lowercase
    appname=${app^^} #uppercase
    version=${firstline:$pos+1:$posf-$pos-1}
    #
    echo '=========================='
    echo 'Building debian package...'
    # debuild --to-tgz-check -S -sa -d -k"$KEY"
    debuild --no-tgz-check -S -sa -d -k"$KEY"
    package="$PARENDIR/$app"_"$version"_source.changes
    if [ -f $package ]; then
        echo '==========================='
        echo "Uploading debian package..."
        dput ppa:"$PPA" "$PARENDIR/$app"_"$version"_source.changes
    else
        echo "Error: package not build"
    fi
    rm "$PARENDIR/$app"_"$version"*
}
