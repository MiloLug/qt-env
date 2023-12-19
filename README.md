# Qt Env

A collection of containers for qt projects compilation.
Esssentially it contains rewrites of [state-of-the-art/qt6-docker](https://github.com/state-of-the-art/qt6-docker) better suited for my projects.

Currently available envs:

- [qt6.6-mingw-64](https://hub.docker.com/repository/docker/kissliava/qt-env/tags?page=1&ordering=last_updated&name=qt6.6-mingw-64) - MinGW64 (with wine) toolchain

# Usage

- qt6.6-mingw-64, a simple QtQuick application

```
docker run -it --rm -v "${PWD}:/home/user/project:rw" kissliava/qt-env:qt6.6-mingw-64 sh -c '
    cd project
    sudo mkdir build
    sudo chmod 777 build
    qt-cmake ./myproject -G Ninja -B ./build
    cmake --build ./build
    mkdir build/dist
    cp build/*.exe build/dist/
    windeployqt --release --dir build/dist/ --qmldir ./myproject --plugindir build/dist/plugins build/dist/*.exe'
```
