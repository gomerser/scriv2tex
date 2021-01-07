#!/bin/bash

# exit when any command fails
set -e

while getopts t: flag
do
    case "${flag}" in
        t) target=${OPTARG};;
    esac
done
echo "${target}"

SCRIPT_DIR="$(dirname "$(stat -f "$0")")"
cd "${SCRIPT_DIR}"
pdflatex -halt-on-error ${target}
makeindex ${target}.idx -s StyleInd.ist
biber ${target}
pdflatex -halt-on-error ${target} x 2
open ${target}.pdf
