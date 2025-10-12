#!/bin/bash

DIR_CURRENT="$(cd "$(dirname "$0")" && pwd)"

TARGET="$(basename "$DIR_CURRENT").rb"

if [ ! -f "$DIR_CURRENT/$TARGET" ]; then
    echo "Error: $TARGET not found in $DIR_CURRENT"
    exit 1
fi

if [ -f "../Gemfile.lock" ]; then
    if ! command -v bundle >/dev/null 2>&1; then
        echo "Error: bundle command not found. Install with 'sudo gem install bundler'"
        exit 1
    fi
    echo "Running with bundle exec..."
    bundle exec ruby "$@" "$DIR_CURRENT/$TARGET"
else
    if ! command -v ruby >/dev/null 2>&1; then
        echo "Error: ruby command not found. Install with 'sudo apt install ruby-full'"
        exit 1
    fi
    echo "Running without bundle..."
    ruby "$@" "$DIR_CURRENT/$TARGET"
fi
