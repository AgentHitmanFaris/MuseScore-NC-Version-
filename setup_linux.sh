#!/bin/bash
# setup_linux.sh
# Automates the installation of dependencies for MuseScore on Debian/Ubuntu based systems.

set -e

echo "========================================"
echo "MuseScore Development Setup (Linux)"
echo "========================================"

# Check for Debian/Ubuntu
if [ ! -f /etc/debian_version ]; then
    echo "Warning: This script is intended for Debian/Ubuntu based systems."
    echo "It uses 'apt-get' to install packages."
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Define packages
PACKAGES=(
  build-essential
  cmake
  ninja-build
  coreutils
  curl
  desktop-file-utils
  gawk
  git
  lcov
  libasound2-dev
  libcups2-dev
  libfontconfig1-dev
  libfreetype6-dev
  libgcrypt20-dev
  libgl1-mesa-dev
  libglib2.0-dev
  libgpgme-dev
  libjack-dev
  libnss3-dev
  libportmidi-dev
  libpulse-dev
  librsvg2-dev
  libsndfile1-dev
  libssl-dev
  libtool
  make
  p7zip-full
  sed
  software-properties-common
  unzip
  wget
  zsync
  libdbus-1-3
  libegl1-mesa-dev
  libgles2-mesa-dev
  libodbc2
  libpq-dev
  libxcomposite-dev
  libxcursor-dev
  libxi-dev
  libxkbcommon-x11-0
  libxrandr2
  libxtst-dev
  libdrm-dev
  libxcb-icccm4
  libxcb-image0
  libxcb-keysyms1
  libxcb-randr0
  libxcb-render-util0
  libxcb-xinerama0
  libxcb-xkb-dev
  libxkbcommon-dev
  libopengl-dev
  libvulkan-dev
  ffmpeg
  libavcodec-dev
  libavformat-dev
  libswscale-dev
  libdbus-1-dev
  libudev-dev
)

echo "Installing dependencies..."
if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO apt-get update
$SUDO apt-get install -y --no-install-recommends "${PACKAGES[@]}"

echo "----------------------------------------"
echo "Dependency installation complete."
echo "----------------------------------------"

# Check for Qt 6
echo "Checking for Qt 6..."
if command -v qmake6 >/dev/null 2>&1; then
    QMAKE=qmake6
    echo "Found qmake6."
elif command -v qmake >/dev/null 2>&1; then
    # Check version
    VERSION=$(qmake -query QT_VERSION)
    if [[ $VERSION == 6.* ]]; then
        QMAKE=qmake
        echo "Found qmake (version $VERSION)."
    else
        echo "Found qmake, but version is $VERSION. MuseScore requires Qt 6."
        QMAKE=""
    fi
else
    QMAKE=""
fi

if [ -z "$QMAKE" ]; then
    echo "Warning: Qt 6 not found or not in PATH."
    echo "MuseScore requires Qt 6 development libraries."
    echo "You can install them via apt (if available) or the online installer."
    echo ""
    echo "Try: sudo apt-get install qt6-base-dev qt6-tools-dev qt6-tools-dev-tools libqt6svg6-dev libqt6opengl6-dev libqt6networkauth6-dev libqt6quick6 libqt6quick3d6 libqt6quick3d6-dev libqt6qml6 libqt6qml6-dev libqt6sql6-sqlite"
    echo ""
    echo "Or download from https://www.qt.io/download"
else
    echo "Qt 6 setup looks good."
fi

echo "========================================"
echo "Setup complete! You can now use './dev.sh build' to compile."
