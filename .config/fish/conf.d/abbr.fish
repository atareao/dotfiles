set -U MY_ABBR_SET true
# applications
abbr --add n nvim
abbr --add vimd nvim -d
abbr --add play ansible-playbook
abbr --add dlm 'yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" --yes-playlist' 
# kitty
abbr --add shs kitty +kitten ssh -q
abbr --add icat kitty +kitten icat
abbr --add mydiff kitty +kitten diff
# general
abbr --add ls lsd
abbr --add la lsd -la
abbr --add lt lsd --tree
abbr --add du dust
# trasher
abbr --add tls trasher --trash-dir ~/.trashdir ls
abbr --add trm trasher --trash-dir ~/.trashdir rm
abbr --add tcl trasher --trash-dir ~/.trashdir clear
# docker
abbr --add compose docker compose $argv
abbr --add dcu docker compose up -d --force-recreate
abbr --add dcl docker compose logs -d
abbr --add dcd docker compose down
abbr --add dc docker compose $argv
# podman
abbr --add pc podman compose
abbr --add pcu podman compose up -d
abbr --add pcr podman compose up -d --force-recreate
abbr --add pcp podman compose ps
abbr --add pcl podman compose logs -f
abbr --add pcd podman compose dowdown
# skim
abbr --add skg 'sk --ansi -i -c \'grep -rI --color=always --line-number "{}" .\''
abbr --add skr 'sk --ansi -i -c \'rg --color=always --line-number "{}"\''
# pnpm
abbr --add pn pnpm
# zapzap
abbr --add zz 'QMLSCENE_DEVICE=softwarecontext QT_OPENGL=software zapzap'
# yadm
abbr --add ypus yadm push
abbr --add yadd yadm add
abbr --add ypul yadm pull
abbr --add ysta yadm status
# git
abbr --add gpus git push
abbr --add gadd git add
abbr --add gpul git pull
abbr --add gsta git status
# paru
abbr --add pclean paru -Rns $(paru -Qdtq)
abbr --add pupdate paru -Syyu
# systemctl --user
abbr --add sysu systemctl --user
abbr --add sustart systemctl --user start
abbr --add sustop systemctl --user stop
abbr --add sustatus systemctl --user status
abbr --add syreload systemctl --user daemon-reload
abbr --add ju journalctl --user
