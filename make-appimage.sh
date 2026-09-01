#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q kate | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://invent.kde.org/utilities/kate/-/raw/master/apps/kate/icons/unix/256-apps-kate.png?ref_type=heads
export DESKTOP=/usr/share/applications/org.kde.kate.desktop
export STARTUPWMCLASS=org.kde.kate
export ALWAYS_SOFTWARE=1
export DEPLOY_KF=1

wget -O quick-sharun "wget https://raw.githubusercontent.com/Samueru-sama/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
chmod +x quick-sharun

# Deploy dependencies
./quick-sharun \
  /usr/bin/kate \
  /usr/bin/konsole \
  /usr/bin/kwrite \
  /usr/bin/exec_inspect.sh \
  /usr/share/kdevappwizard \
  /usr/share/color-schemes \
  /usr/share/kstyle \
  /usr/share/kateproject \
  /usr/share/katexmltools \
  /usr/share/zsh \
  /usr/lib/qt6/plugins/kf6/ktexteditor \
  /usr/share/org.kde.syntax-highlighting \
  /usr/share/applications/org.kde.kwrite.desktop

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
