#!/bin/sh
# Script to install Qt 6 in docker container

AQT_URL="https://github.com/miurahr/aqtinstall/releases/download/v$AQT_VERSION/aqt.exe"

# Init the package system
. /scripts/apt_env

echo '--> Install the required packages to install Qt'

add_pkg curl 
echo "$AQT_SHA256 -" > sum.txt && curl -fLs "$AQT_URL" | tee /tmp/aqt.exe | sha256sum -c sum.txt

echo '--> Download & install the Qt library using aqt'

sudo -E ln -s /usr/bin/wine64-stable /usr/local/bin/wine

wine /tmp/aqt.exe install-qt -O "$QT_PATH" windows desktop "$QT_VERSION" win64_mingw
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_mingw90
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_cmake
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_ninja
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_opensslv3_x64
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_vcredist

sudo -E chmod +x /usr/local/bin/*

exit_env

