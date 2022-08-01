dir := "${PWD##*/}"
upload_blocks:
    rsync --archive \
          --verbose \
          --human-readable \
          --delete \
          --exclude '.git' \
          --exclude '.justfile' \
          ../blocks/ co1:docker/wpap/html/wp-content/plugins/blocks
zip:
    #zip -r  "${PWD##*/}".zip rester/* -x rester/.git
    echo {{ dir }}
    zip -r "../{{dir}}.zip" ./* -x ./.git
