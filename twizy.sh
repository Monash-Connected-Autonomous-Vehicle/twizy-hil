#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    echo "Usage:"
    echo "  ./twizy.sh setup"
    echo "  ./twizy.sh interface"
    echo "  ./twizy.sh controller"
    echo "  ./twizy.sh branch-test <branchname>"
}

COMMAND="${1:-}"

case "$COMMAND" in
    setup)
        "$SCRIPT_DIR/setup.sh"
        ;;
    interface)
        "$SCRIPT_DIR/first.sh"
        ;;
    controller)
        "$SCRIPT_DIR/second.sh"
        ;;
    branch-test)
        BRANCH="${2:-}"
        if [[ -z "$BRANCH" ]]; then
            echo "Error: branch-test requires <branchname>"
            echo
            usage
            exit 1
        fi
        "$SCRIPT_DIR/branch-test.sh" "$BRANCH"
        ;;
    *)
        usage
        exit 1
        ;;
esac