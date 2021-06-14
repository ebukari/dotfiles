#!/bin/bash

VERSION="$(./lua_latest.py)"
PACKAGE_NAME="$VERSION.tar.gz"
CURRENT_DIR="$(pwd)"

TEMP_DIRECTORY=$(mktemp -d)

cd $TEMP_DIRECTORY

echo ".........................."
echo "Downloading $PACKAGE_NAME"
echo ".........................."
curl -R -O "https://www.lua.org/ftp/$PACKAGE_NAME"

echo ".........................."
echo "Extracting $PACKAGE_NAME"
echo ".........................."
tar -zxf "$PACKAGE_NAME"
cd "$VERSION"

echo ".........................."
echo "Making and installing"
echo ".........................."
make linux test
sudo make install
cd "$CURRENT_DIR"
