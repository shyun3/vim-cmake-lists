# vim-cmake-lists
Vim plugin for navigation of CMakeLists.txt files

## Installation
It is recommended to use a plugin manager to install, such as
[Vundle](https://github.com/VundleVim/Vundle.vim) or
[minpac](https://github.com/k-takata/minpac).

## Usage
**:CMakeLists**  
Open the CMakeLists.txt file for the directory of the currently selected
buffer.

**:CMakeLists _{directory}_**  
Open the CMakeLists.txt file for the given _{directory}_. The directory may be
given as an absolute or relative path. If relative, the path will be
interpreted relative to the directory of the currently selected buffer.

**:CMakeLists! _[directory]_**  
Edit the CMakeLists.txt file for the _[directory]_ always, similar to `:edit!`.

**gf**  
Open the CMakeLists.txt file for the directory under or after the cursor.
Directory paths may be either absolute or relative.
