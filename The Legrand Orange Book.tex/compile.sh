#!/bin/bash

# exit when any command fails
set -e

while getopts ":n:t:" opt; do
  case ${opt} in
    n  ) name=${OPTARG};;
    t  ) target=${OPTARG};;
    \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
    :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
  esac
done

if ((OPTIND == 1))
then
  echo "No options specified"
  exit 1
fi

SCRIPT_DIR="$(dirname "$(stat -f "$0")")"
cd "${SCRIPT_DIR}"
pdflatex -halt-on-error -jobname="${name}" "${target}"
makeindex "${name}.idx" -s StyleInd.ist
biber "${name}"
pdflatex -halt-on-error -jobname="${name}" "${target}" x 2
open "${name}.pdf"
