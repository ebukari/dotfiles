#!/bin/bash
# shellcheck disable=SC2016
set -e

VERSION="$(./golang_latest_version.py)"
OS="$(uname -s)"
ARCH="$(uname -m)"

case $OS in
    "Linux")
        case $ARCH in
        "x86_64")
            ARCH=amd64
            ;;
        "aarch64")
            ARCH=arm64
            ;;
        "armv6" | "armv7l")
            ARCH=armv6l
            ;;
        "armv8")
            ARCH=arm64
            ;;
        .*386.*)
            ARCH=386
            ;;
        esac
        PLATFORM="linux-$ARCH"
    ;;
    "Darwin")
        PLATFORM="darwin-amd64"
    ;;
esac

if [ -z "$PLATFORM" ]; then
    echo "Your operating system is not supported by the script."
    exit 1
fi

PACKAGE_NAME="go$VERSION.$PLATFORM.tar.gz"
TEMP_DIRECTORY=$(mktemp -d)

echo "PACKAGE_NAME: $PACKAGE_NAME"
echo "TEMP_DIRECTORY: $TEMP_DIRECTORY"

PACKAGE_PATH="$TEMP_DIRECTORY/$PACKAGE_NAME"

echo "Downloading $PACKAGE_NAME ..."
echo "PACKAGE_PATH: $PACKAGE_PATH"
if hash wget 2>/dev/null; then
    echo "Using wget........\n"
    wget "https://golang.org/dl/$PACKAGE_NAME" -O "$PACKAGE_PATH"
else
    echo "Using curl.............\n"
    curl -o "$PACKAGE_PATH" "https://golang.org/dl/$PACKAGE_NAME"
fi


if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Contents of temp directory: "
ls $TEMP_DIRECTORY


echo "Extracting File..."
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$PACKAGE_PATH"
