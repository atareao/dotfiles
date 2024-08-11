#!/bin/sh

REPO_A=co1:/home/lorenzo/backup/repo_ubuntu
REPO_B=/datos/backup/ubuntu
REPO_C=synology:/var/services/homes/lorenzo/backup/repo_ubuntu

#Bail if borg is already running, maybe previous run didn't finish
if pidof -x borg >/dev/null; then
    echo "Backup already running"
    exit
fi

# Setting this, so you won't be asked for your repository passphrase:
#-- export BORG_PASSPHRASE=''
# or this to ask an external program to supply the passphrase:
export BORG_PASSCOMMAND='gkeyring -g -k borgbackup'

for REPOSITORY in ${REPO_A} ${REPO_B} ${REPO_C}
do
    # Backup all of /dats/Sync except a few excluded directories
    borg create -v --stats                          \
        "${REPOSITORY}"::'{hostname}-{now:%Y-%m-%d}'    \
        /datos/dotfiles                             \
        /datos/Sync                                 \
        --exclude '/datos/Sync/Ansible'             \
        --exclude '/datos/Sync/backup'              \
        --exclude '/datos/Sync/CompartirWeb'        \
        --exclude '/datos/Sync/CryFS'               \
        --exclude '/datos/Sync/driver'              \
        --exclude '/datos/Sync/EncFS'               \
        --exclude '/datos/Sync/Programacion'        \
        --exclude '/datos/Sync/Ruido'               \
        --exclude '*.aup'                           \
        --exclude '*.au'                            \
        --info 2>>/datos/logs/borg.log
    # Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
    # archives of THIS machine. The '{hostname}-' prefix is very important to
    # limit prune's operation to this machine's archives and not apply to
    # other machine's archives also.
    borg prune -v --list "${REPOSITORY}" --prefix '{hostname}-' \
        --keep-daily=3 --keep-weekly=2 --keep-monthly=3
done
