#!/bin/bash

function translate()
{
    package=$(jq '.name' metadata.json)
    package=${package//\"/}
    version=$(jq '.version' metadata.json)
    uuid=$(jq '.uuid' metadata.json)
    uuid=${uuid//\"/}

    echo '==== Update translations ===='
    echo ''
    if [[ -f po/messages.pot ]];then
        rm po/messages.pot
    fi
    touch po/messages.pot
    find schemas/ -iname "*.xml" | xargs xgettext -j -L GSettings --from-code=UTF-8 -k_ -kN_ -o po/messages.pot
    find . -iname "*.js" | xargs xgettext -j -L JavaScript --from-code=UTF-8 -k_ -kN_ -o "po/messages.pot"
    if [[ -d locale ]];then
        rm -rf locale/
    fi
    for i in po/*.po;do
        echo "=== ${i} ==="
        filename=$(basename "${i}")
        lang=${filename/.po}
        file_size=$(wc -c < "${i}")
        if [[ "${file_size}" -gt 0 ]];then
            msgmerge -U "${i}" "po/messages.pot"
        else
            msginit --output-file="${i}" --input=po/messages.pot --locale="${lang}"
        fi
        sed -i -e 's/charset=ASCII/charset=UTF-8/g' "${i}"
        sed -i -e "s/PACKAGE VERSION/${package} - ${version}/g" "${i}"
        sed -i -e "s/PACKAGE package/${package} package/g" "${i}"
        ## Translations
        if [[ ! -d "locale/${lang}" ]];then
            mkdir -p "locale/${lang}/LC_MESSAGES"
        fi
        msgfmt "${i}" -o "locale/${lang}/LC_MESSAGES/${uuid}.mo"
    done
    for i in po/*.po~;do
        if [[ -f "${i}" ]];then
            rm "${i}"
        fi
    done
}

function compile()
{
    echo '==== Compiling schemas ===='
    echo ''
    glib-compile-schemas schemas
}

function compress()
{
    echo '==== Compress directory ===='
    echo ''
    file="../${PWD##*/}.zip"
    echo "${file}"
    if [[ -f "${file}" ]];then
        rm "${file}"
    fi
    zip -r --exclude=.git/\* \
           --exclude=\*.vscode\* \
           --exclude=po/\* \
           --exclude=scripts/\* \
           --exclude=screenshots/\* \
           --exclude=.gitignore \
           --exclude=helper.sh \
           "${file}" .
}

function usage()
{
    echo "Copyright (c) 2018 Lorenzo Carbonell https://www.atareao.es"
    echo "Helper 0.1.0 (20180603). USage:"
    echo "helper [-option]"
    echo "    The default option is to show this help."
    echo "    -c    compile schemas"
    echo "    -h    show this help"
    echo "    -t    update translations and compile"
    echo "    -z    compress directory"

}
function helpere()
{
    if [[ $# -gt 0 ]]; then
        case $1 in
            -h) usage
                ;;
            -t) translate
                ;;
            -c) compile
                ;;
            -z) compress
                ;;
            * ) usage
                ;;
        esac
    else
        usage
    fi
}
