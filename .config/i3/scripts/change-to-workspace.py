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

import i3ipc
import sys
from plumbum import local


def change(index):
    index = int(index)
    if index > -1 and index < 10:
        eww = local["eww"]
        sway = i3ipc.Connection()
        tree = sway.get_tree()
        for workspace in tree.workspaces():
            if workspace.name.startswith(str(index)):
                workspace.descendants()[0].command("focus")
                eww["update", f"workspace={index}"]()
                exit(0)
        sway.command(f"workspace {index}")
        eww["update", f"workspace={index}"]()


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1].isnumeric():
        change(sys.argv[1])
