#!/bin/bash

set -euo pipefail

WORKSPACE="$HOME/basic_ua_ctrl_ws"

usage() {
    echo "Usage: $0 <branch-name>"
    echo
    echo "Examples:"
    echo "  $0 feature/my-branch"
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

BRANCH="$1"

REPO_DIR="$WORKSPACE/src/SD-VehicleInterface"

if [[ ! -d "$REPO_DIR/.git" ]]; then
    echo "Error: SD-VehicleInterface repo not found at:"
    echo "  $REPO_DIR"
    exit 1
fi

cd "$REPO_DIR"

git fetch origin

if ! git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1; then
    echo "Error: Remote branch 'origin/$BRANCH' was not found."
    exit 1
fi

if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
    git switch "$BRANCH"
else
    git switch -c "$BRANCH" --track "origin/$BRANCH"
fi

git pull --ff-only origin "$BRANCH"

echo
echo "Switched and updated SD-VehicleInterface branch: $BRANCH"
echo "Repo: $REPO_DIR"
