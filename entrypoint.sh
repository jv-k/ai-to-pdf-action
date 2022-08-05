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
OVERWRITE=${4}
GH_REPO=${5}
GH_BRANCH=${6}
GH_COMMIT_MESSAGE=${7}

GITHUB_ACTOR=${8}
GITHUB_TOKEN=${9}

if [ -z "$GS_INPUT_FILE" ] || [ ! -f "$GS_INPUT_FILE" ]; then
  error "Input file <${GS_INPUT_FILE}> is empty or doesn't exist."
fi

[ -f "$GS_OUTPUT_FILE" ] && [ -z "$OVERWRITE" ] && \
  error "Output file <${GS_OUTPUT_FILE}> already exists — please use another name."

[ -z "${GITHUB_TOKEN}" ] && {
    echo "Missing input \"github_token: \${{ secrets.GITHUB_TOKEN }}\"."
    exit 1
}

cmd_gs="gs ${GS_DEFAULT_PARAMS} -sOutputFile=${GS_OUTPUT_FILE} ${GS_OPTIONAL_PARAMS} ${GS_INPUT_FILE}"

cmd_set_safe_dir="git config --global --add safe.directory /github/workspace"

# Copy the name and email from the last commit
cmd_set_email="git config --local user.email \"\$(git log --format='%ae' HEAD^\!)\""
cmd_set_name="git config --local user.name \"\$(git log --format='%an' HEAD^\!)\""

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GH_REPO}.git"

cmd_stage="git add ${GS_OUTPUT_FILE}"
cmd_commit="git commit -m \"${GH_COMMIT_MESSAGE}\""
cmd_push="git push \"${remote_repo}\" HEAD:${GH_BRANCH} --force"

eval "$cmd_set_safe_dir" && \
eval "$cmd_set_email" && \
eval "$cmd_set_name" && \
eval "$cmd_gs" && \
eval "$cmd_stage" && \
eval "$cmd_commit" && \
eval "$cmd_push"