#!/bin/sh

set -e

warn() {
  echo "::warning :: $1"
}

error() {
  echo "::error :: $1"
  exit 1
}

# variable
INPUT_FILE="$1"
OUTPUT_FILE="$2"
OPTIONAL_PARAMS="$3"
COMMIT_MESSAGE="$4"

DEFAULT_PARAMS="-sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH"

if [ -z "$INPUT_FILE" ] || [ ! -f "$INPUT_FILE" ]; then
  error "Input file <${INPUT_FILE}> is empty or doesn't exist."
fi

if [ -f "$OUTPUT_FILE" ]; then
  error "Output file <${OUTPUT_FILE}> already exists — please use another name."
fi


cmd_gs='gs ${DEFAULT_PARAMS} -sOutputFile=${OUTPUT_FILE} ${OPTIONAL_PARAMS} ${INPUT_FILE}'
cmd_stage='git add ${OUTPUT_FILE}'
cmd_setup_commit='git config user.name "GitHub Actions Bot" && git config user.email "<>"'
cmd_commit='git commit -m "${COMMIT_MESSAGE}"'
cmd_push='git push origin master'

eval "$cmd_gs" \
  && eval "$cmd_stage" \
  && eval "$cmd_setup_commit" \
  && eval "$cmd_commit" \
  && eval "$cmd_push"