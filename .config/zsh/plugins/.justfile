update:
    find . -maxdepth 1 -mindepth 1 -type d  -not \( -path ./atareao -prune \) -exec git --git-dir={}/.git --work-tree=$PWD/{} pull  \;
