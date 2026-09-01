#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    kate         \
    qtkeychain-qt6 \
    kparts \
    breeze \
    konsole \
    syntax-highlighting \
    qt6ct \
    kvantum \
    lxqt-qtplugin

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano kiconthemes-mini
