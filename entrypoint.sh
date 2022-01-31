#!/bin/sh

set -e

warn() {
  echo "::warning :: $1"
}

error() {
  echo "::error :: $1"
  exit 1
}

# arguments
GS_INPUT_FILE=${1}
GS_OUTPUT_FILE=${2}
GS_OPTIONAL_PARAMS=${3}
GS_DEFAULT_PARAMS="-sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH"

GH_REPO=${4}
GH_BRANCH=${5}
GH_FORCE=${6} #${$6:-false}
GH_TAGS=${7} #${$7:-false}
GH_COMMIT_MESSAGE=${8}

GITHUB_ACTOR=${9}
GITHUB_TOKEN=${10}

if [ -z "$GS_INPUT_FILE" ] || [ ! -f "$GS_INPUT_FILE" ]; then
  error "Input file <${GS_INPUT_FILE}> is empty or doesn't exist."
fi

if [ -f "$GS_OUTPUT_FILE" ]; then
  error "Output file <${GS_OUTPUT_FILE}> already exists — please use another name."
fi

[ -z "${GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

if ${INPUT_TAGS}; then
    _TAGS='--tags'
fi

cmd_gs='gs ${GS_DEFAULT_PARAMS} -sOutputFile=${GS_OUTPUT_FILE} ${GS_OPTIONAL_PARAMS} ${GS_INPUT_FILE}'

# Copy the name and email from the last commit
cmd_set_email='git config --local user.email "$(git log --format='"'"'%ae'"'"' HEAD^!)"'
cmd_set_name='git config --local user.name "$(git log --format='"'"'%an'"'"' HEAD^!)"'

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GH_REPO}.git"

cmd_stage="git add ${GS_OUTPUT_FILE}"
cmd_commit="git commit -m \"${GH_COMMIT_MESSAGE}\""
cmd_push="git push \"${remote_repo}\" HEAD:${GH_BRANCH}" # --follow-tags $_FORCE_OPTION $_TAGS'


eval "$cmd_set_email" && \ 
eval "$cmd_set_name" && \
eval "$cmd_gs" && \
eval "$cmd_stage" && \
eval "$cmd_commit" && \
eval "$cmd_push"


