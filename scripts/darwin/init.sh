#!/usr/bin/env bash
dir="$(readlink -f $(dirname $BASH_SOURCE))"

echo "Installing Colemak DH..."
sudo cp -r "$dir/files/Colemak DH.bundle" "/Library/Keyboard Layouts/Colemak DH.bundle"

echo "Done!"
