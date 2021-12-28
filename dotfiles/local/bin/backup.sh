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

#!/bin/sh

REPO_A='/home/lorenzo/borgbackup|/usr/bin/borg'
REPO_B='belcar:/var/services/homes/lorenzo/backup/repo_manjaro|/usr/local/bin/borg'
REPO_C='co1:/home/lorenzo/backup/repo_manjaro|/usr/bin/borg'
REPOS=($REPO_A $REPO_B $REPO_C)

#Bail if borg is already running, maybe previous run didn't finish
if pidof -x borg >/dev/null; then
    echo "Backup already running"
    exit
fi

export BORG_PASSPHRASE="{{@@ env['BORGBACKUP'] @@}}"
for ITEM in ${REPOS[@]}
do
    REPOSITORY=${ITEM%%|*}
    BORGPATH=${ITEM##*|}
    echo "=== Start backup at $REPOSITORY ==="
    borg create -v --stats                          \
        $REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
        /home/lorenzo/atareao.es                    \
        /home/lorenzo/dockers                       \
        /home/lorenzo/Imágenes                      \
        /home/lorenzo/kk                            \
        /home/lorenzo/python                        \
        /home/lorenzo/Vídeos                        \
        /home/lorenzo/bash                          \
        /home/lorenzo/javascript                    \
        /home/lorenzo/rust                          \
        --exclude '*.aup'                           \
        --exclude '*.au'                            \
        --remote-path "${BORGPATH}"                 \
        --info
    # Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
    borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
        --keep-daily=7 --keep-weekly=4 --keep-monthly=6     \
        --remote-path "${BORGPATH}"
    echo "=== End backup at $REPOSITORY ==="
done

