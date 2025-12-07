#!/bin/bash
# dev.sh
# A simple wrapper script for MuseScore development tasks.

set -e

# Change to the script's directory (root of the repo)
cd "$(dirname "$0")"

function show_help {
    echo "Usage: ./dev.sh [command]"
    echo ""
    echo "Commands:"
    echo "  setup       Install dependencies (Linux only)"
    echo "  build       Build MuseScore (Debug mode)"
    echo "  release     Build MuseScore (Release mode)"
    echo "  run         Run the compiled MuseScore (Debug mode)"
    echo "  clean       Clean the build directory"
    echo "  help        Show this help message"
    echo ""
}

if [ -z "$1" ]; then
    show_help
    exit 1
fi

COMMAND=$1

case $COMMAND in
    setup)
        if [ -f "./setup_linux.sh" ]; then
            ./setup_linux.sh
        else
            echo "Error: setup_linux.sh not found."
            exit 1
        fi
        ;;
    build)
        echo "Building MuseScore (Debug)..."
        cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug
        ;;
    release)
        echo "Building MuseScore (Release)..."
        cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release
        ;;
    run)
        echo "Running MuseScore..."
        cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug run
        ;;
    test)
        echo "Building and Running Tests..."
        cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug test
        ;;
    clean)
        echo "Cleaning build directory..."
        cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug clean
        ;;
    help)
        show_help
        ;;
    *)
        echo "Unknown command: $COMMAND"
        show_help
        exit 1
        ;;
esac
