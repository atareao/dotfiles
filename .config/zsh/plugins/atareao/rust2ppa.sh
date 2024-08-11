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


function rust2ppa(){
    KEY=726BF28194F177B10C85F46D0AD17DF58AA94BFB
    PPA="atareao/test"
    MAIN_DIR=${PWD}
    BASENAME=$(basename ${PWD})
    DEBIAN_DIR=${PWD}/debian
    PARENT_DIR=$(dirname ${MAIN_DIR})

    if [ -d debian ] && [ -f Cargo.toml ]
    then
        dh clean
        if [ ! -d vendor ]
        then
            #cd debian
            cargo vendor
            #tar cvzf vendor.tar.gz vendor
            #rm -rf vendor
            #echo "vendor.tar.gz" > source/include-binaries
            #cd ..
        fi
        name_longversion=$(head -n1 debian/changelog)
        name_longversion=${name_longversion%%\)*}
        name=${name_longversion%% *}
        longversion=${name_longversion##*\(}
        version=${longversion%%-*}
        tarfile="${name}_${version}.orig.tar.gz"
        changes_file="${name}_${longversion}_source.changes"
        tar cvzf ../${tarfile} ../${BASENAME}
        debuild -S -sa -d -k${KEY}
        if [ -f $package ]; then
            echo '==========================='
            echo "Uploading debian package..."
            dput ppa:"$PPA" "${PARENT_DIR}/${changes_file}"
        else
            echo "Error: package not build"
        fi
        rm "${PARENT_DIR}/${name}_${version}"*
        dh clean
        return 0
    else
        if [ ! -d debian ]
        then
            echo "This isn't the right directory to upload to PPA"
        else
            echo "This isn't a Rust application to upload to PPA"
        fi
        return 1
    fi
}
