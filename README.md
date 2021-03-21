This homebrew tap is packaging dependencies for freecad.

The recipies are based on the one found in FreeCAD/homebrew-freecad.

---
## FreeCAD Build Instructions

first untap freecad/freecad and remove all packages that is installed from that tap (we don't want any collisions):

`brew untap freecad/freecad`

install dependencies:

`brew install qt@5 pyqt@5 pyside@2 opencascade vtk@8.2`

install additional dependencies:

```bash
brew tap hyarion/freecad-deps
brew install hyarion/freecad-deps/med-file hyarion/freecad-deps/nglib hyarion/freecad-deps/pyside-tools@2

pip3 install Matplotlib
```

Add the line:

```
string(STRIP "${PYTHON_INCLUDE_DIRS}" PYTHON_INCLUDE_DIRS)
```
to `/usr/local/opt/pyside\@2/lib/cmake/Shiboken2-5.15.2/shiboken_helpers.cmake` just above the line (around line 353):

```
if (SHIBOKEN_COMPUTE_INCLUDES_IS_CALLED_FROM_EXPORT)` at around line 353
```

Run cmake like this from your build directory:

```
cmake \
        -DCMAKE_PREFIX_PATH="\
/usr/local/opt/qt@5/lib/cmake;\
/usr/local/opt/nglib/Contents/Resources;\
/usr/local/opt/vtk@8.2/lib/cmake;\
/usr/local/opt/pyside@2/lib/cmake;\
/usr/local/opt/python-boost/lib/cmake;\
/usr/local/opt/coin3d/lib/cmake;\
/usr/local/opt/icu4c/lib;\
" \
        -DBUILD_QT5:BOOL=ON \
        -DUSE_PYTHON3:BOOL=ON \
        -DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
        -DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
        -DBUILD_FEM_NETGEN=1 \
        -DBUILD_FEM=1 \
        -DBUILD_FEM_NETGEN:BOOL=ON \
        -DFREECAD_USE_EXTERNAL_KDL=ON \
        -DCMAKE_BUILD_TYPE=release \
        ../FreeCAD-git
```

## Run FreeCAD
Freecad can now be run with `./bin/FreeCAD -P /usr/local/opt/pyside@2/lib/python3.9/site-packages;/usr/local/opt/coin3d/lib/python3.9/site-packages/`
