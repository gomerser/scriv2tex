#!/bin/bash

SCRIPT_DIR="$(dirname "$(stat -f "$0")")"
echo XXX
echo ${SCRIPT_DIR}
while getopts t: flag
do
    case "${flag}" in
        t) target=${OPTARG};;
    esac
done
echo "${target}"

cd "${SCRIPT_DIR}"
pdflatex ${target}
makeindex ${target}.idx -s StyleInd.ist
biber ${target}
pdflatex ${target} x 2
open ${target}.pdf
