#!/bin/sh -xe

echo '--> Set Qt and Tools PATH for wine'

cat - <<EOF > /tmp/path.reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\\Environment]
"Path"="$(find "/home/user/.wine/drive_c/Qt" -type d -name bin -o -name Ninja | sed "s|/home/user/.wine/drive_c|C:|" | sed 's|/|\\\\|g' | tr '\n' ';')"
EOF

# Wait for the registry to be updated (it's done asynchronously)
before=$(stat -c '%Y' /home/user/.wine/user.reg 2>/dev/null || echo 0)
wine regedit /tmp/path.reg
while [ $(stat -c '%Y' /home/user/.wine/user.reg) = $before ]; do sleep 0\.5; done

echo '--> Create helper functions'

cat - <<\EOF | sudo -E tee /usr/local/bin/qt-cmake
#!/bin/sh
wine cmd /c qt-cmake "$@"
EOF

cat - <<\EOF | sudo -E tee /usr/local/bin/cmake
#!/bin/sh
wine cmake "$@"
EOF

cat - <<\EOF | sudo -E tee /usr/local/bin/ninja
#!/bin/sh
wine ninja "$@"
EOF

cat - <<\EOF | sudo -E tee /usr/local/bin/windeployqt
#!/bin/sh
wine windeployqt "$@"
EOF

sudo chmod +x /usr/local/bin/*
sudo rm -rf /tmp/*

