#!/bin/bash

cd i3/i3 || exit
poetry run python autoname-workspaces.py
poetry run python autotiling.py
poetry run python change-to-workspace.py
poetry run python inactive-windows-transparency.py

