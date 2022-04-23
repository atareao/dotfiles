#!/usr/bin/env python3
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

"""
This script uses the i3ipc python module to switch the layout splith / splitv
for the currently focused window, depending on its dimensions.
It works on both sway and i3 window managers.

Inspired by https://github.com/olemartinorg/i3-alternating-layout

Copyright: 2019-2021 Piotr Miller & Contributors
e-mail: nwg.piotr@gmail.com
Project: https://github.com/nwg-piotr/autotiling
License: GPL3

Dependencies: python-i3ipc>=2.0.1 (i3ipc-python)
"""
import argparse
import os
import sys
from functools import partial
from tendo import singleton

from i3ipc import Connection, Event


def temp_dir():
    adir = os.getenv("TMPDIR")
    if adir:
        return adir
    adir = os.getenv("TEMP")
    if adir:
        return adir
    adir = os.getenv("TMP")
    if adir:
        return adir

    return "/tmp"


def save_string(string, file):
    try:
        file = open(file, "wt")
        file.write(string)
        file.close()
    except Exception as e:
        print(e)


def switch_splitting(i3, _, debug, workspaces):
    try:
        con = i3.get_tree().find_focused()
        if con and not workspaces or (str(con.workspace().num) in workspaces):
            if con.floating:
                # We're on i3: on sway it would be None
                # May be 'auto_on' or 'user_on'
                is_floating = "_on" in con.floating
                is_full_screen = con.fullscreen_mode == 1
            else:
                # We are on sway
                is_floating = con.type == "floating_con"
                is_full_screen = con.fullscreen_mode == 1

            is_stacked = con.parent.layout == "stacked"
            is_tabbed = con.parent.layout == "tabbed"

            # Exclude floating containers, stacked layouts, tabbed layouts and
            # full screen mode
            if (not is_floating
                    and not is_stacked
                    and not is_tabbed
                    and not is_full_screen):
                new_layout = "splitv" if con.rect.height > con.rect.width \
                        else "splith"

                if new_layout != con.parent.layout:
                    result = i3.command(new_layout)
                    if result[0].success and debug:
                        print("Debug: Switched to {}".format(new_layout),
                              file=sys.stderr)
                    elif debug:
                        print("Error: Switch failed with err {}".format(
                            result[0].error), file=sys.stderr, )

        elif debug:
            print("Debug: No focused container found or autotiling on the \
                    workspace turned off", file=sys.stderr)

    except Exception as exception:
        print("Error: {}".format(exception), file=sys.stderr)


def main():
    me = singleton.SingleInstance()
    parser = argparse.ArgumentParser()
    parser.add_argument("-d",
                        "--debug",
                        action="store_true",
                        help="print debug messages to stderr")
    parser.add_argument("-v",
                        "--version",
                        action="version",
                        help="display version information", )
    parser.add_argument("-w",
                        "--workspaces",
                        help=("restricts autotiling to certain workspaces; "
                              "example: autotiling --workspaces 8 9"),
                        nargs="*",
                        type=str,
                        default=[], )
    """
    Changing event subscription has already been the objective of several pull
    request. To avoid doing this again and again, let's allow to specify them
    in the `--events` argument.
    """
    parser.add_argument("-e",
                        "--events",
                        help=("list of events to trigger switching split "
                              "orientation; default: WINDOW MODE"),
                        nargs="*",
                        type=str,
                        default=["WINDOW", "MODE"])

    args = parser.parse_args()

    if args.debug and args.workspaces:
        print("autotiling is only active on workspaces:", ','.join(
            args.workspaces))

    # For use w/ nwg-panel
    if args.workspaces:
        save_string(','.join(args.workspaces), os.path.join(temp_dir(),
                                                            "autotiling"))

    if not args.events:
        print("No events specified", file=sys.stderr)
        sys.exit(1)

    handler = partial(switch_splitting, debug=args.debug,
                      workspaces=args.workspaces)
    i3 = Connection()
    for e in args.events:
        try:
            i3.on(Event[e], handler)
            print("{} subscribed".format(Event[e]))
        except KeyError:
            print("'{}' is not a valid event".format(e), file=sys.stderr)

    i3.main()


if __name__ == "__main__":
    # execute only if run as a script
    main()
