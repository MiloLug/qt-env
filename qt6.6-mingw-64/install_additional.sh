#!/bin/sh

# Init the package system
. /scripts/apt_env

add_pkg curl unzip

echo '--> Install additional tools'

# GIT
curl -fLs https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/MinGit-2.43.0-busybox-64-bit.zip -o /tmp/git.zip
unzip -q /tmp/git.zip -d /tmp/win-git
mv /tmp/win-git/cmd /tmp/win-git/bin
cp -r /tmp/win-git "/home/user/.wine/drive_c/Qt/Tools/git"

sudo -E chmod +x /usr/local/bin/*

exit_env

