update:
    find . -maxdepth 1 \
           -mindepth 1 \
           -type d \
           -not \( -path ./atareao -prune \) \
           -not \( -path ./custom-completions -prune \) \
           -printf "%P\n" \
           -exec git \
           --git-dir={}/.git \
           --work-tree=$PWD/{} pull  \;
