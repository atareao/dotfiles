#!/usr/bin/env zsh
# -*- coding: utf-8 -*-

# Copyright (c) 2023 Lorenzo Carbonell <a.k.a. atareao>

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

# borrowed from https://github.com/moby/moby/issues/25245
# improved not to use global name docker_volume_cp for the temp container name

function dcat() {
	SOURCE=$1
    SOURCE_ARR=(${(@s/:/)SOURCE})

	if [[ -z $VOLUME ]]; then
		echo "Usage:"
		echo " $0 VOLUME:PATH"
	else
		VOL=${SOURCE_ARR[1]}
		VOL_PATH=${SOURCE_ARR[2]}
		docker run -it \
			--rm \
			--init \
			--name "busybox_${VOL:l}" \
			-v "${VOL}:/${VOL}" \
			busybox cat "/${VOL}${VOL_PATH}"
	fi
}

function dcp() {
	SOURCE=$1
	DEST=$2

    SOURCE_ARR=(${(@s/:/)SOURCE})
    DEST_ARR=(${(@s/:/)DEST})

	if [[ ${#SOURCE_ARR[@]} -eq 2 && ${#DEST_ARR[@]} -eq 1 ]]; then
		VOL=${SOURCE_ARR[0]}
		VOL_PATH=${SOURCE_ARR[1]}
		HOST_PATH=${DEST_ARR[0]}
		echo " volume --> host: $0 ${VOL}:${VOL_PATH} ${HOST_PATH}"

		id=$(docker container create -v "$VOL:/volume" busybox)
		CMD=docker cp "$id:/volume/${VOL_PATH}" "${HOST_PATH}"
		echo "$CMD"
		echo $CMD
		docker rm "$id"

	elif [[ ${#SOURCE_ARR[@]} -eq 1 && ${#DEST_ARR[@]} -eq 2 ]]; then
		VOL=${DEST_ARR[1]}
		VOL_PATH=${DEST_ARR[2]}
		HOST_PATH=${SOURCE_ARR[1]}
		echo " host --> volume: $0 ${HOST_PATH} ${VOL}:${VOL_PATH}"

		id=$(docker container create --name docker_volume_cp -v "$VOL:/volume" "busybox")
		CMD="docker cp $HOST_PATH $id:/volume${VOL_PATH}"
		echo "$CMD"
		eval ${CMD}
		docker rm "$id"
	else
		echo "Usage:"
		echo " volume --> host: $0 VOLUME:VOL_PATH HOST_PATH"
		echo " host --> volume: $0 HOST_PATH VOLUME:VOL_PATH"
	fi
}

function dls() {
	SOURCE=$1
    SOURCE_ARR=(${(@s/:/)SOURCE})

	if [[ -z $VOLUME ]]; then
		echo "Usage:"
		echo " $0 VOLUME:PATH"
	else
		VOL=${SOURCE_ARR[1]}
		VOL_PATH=${SOURCE_ARR[2]}
		docker run -it \
			--rm \
			--init \
			--name "busybox_${VOL:l}" \
			-v "${VOL}:/${VOL}" \
			busybox ls -la "/${VOL}${VOL_PATH}"
	fi
}

function dmnt() {
	VOLUME=$1

	if [[ -z $VOLUME ]]; then
		echo "Usage:"
		echo " $0 VOLUME"
	else
		docker run -it \
			--rm \
			--init \
			--name "busybox_${VOLUME:l}" \
			-v "${VOLUME}:/${VOLUME}" \
			busybox sh
	fi
}
