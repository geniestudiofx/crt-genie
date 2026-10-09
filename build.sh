#!/bin/sh
# Builds CRT Genie.exe with the MinGW-w64 cross compiler (Linux / WSL / MSYS2).
#   Ubuntu/WSL:  sudo apt install g++-mingw-w64-x86-64-posix
#   MSYS2:       pacman -S mingw-w64-x86_64-gcc   (then run this from the MINGW64 shell, with CROSS= )
set -e
cd "$(dirname "$0")"
CROSS=${CROSS-x86_64-w64-mingw32-}
IM=third_party/imgui
GL=third_party/glfw
mkdir -p build
CXX="${CROSS}g++ -O2 -std=c++17 -DUNICODE -D_UNICODE -I$IM -I$IM/backends -I$GL/include -Isrc"
for f in imgui imgui_draw imgui_tables imgui_widgets; do [ build/$f.o -nt $IM/$f.cpp ] || $CXX -c $IM/$f.cpp -o build/$f.o; done
for f in imgui_impl_glfw imgui_impl_opengl3; do [ build/$f.o -nt $IM/backends/$f.cpp ] || $CXX -c $IM/backends/$f.cpp -o build/$f.o; done
$CXX -c src/media.cpp -o build/media.o
$CXX -c src/main.cpp -o build/main.o
${CROSS}windres -I src src/app.rc -O coff -o build/app.o
$CXX -mwindows -municode build/*.o $GL/lib-mingw-w64/libglfw3.a -static -static-libgcc -static-libstdc++ \
  -lopengl32 -lgdi32 -lmfplat -lmfreadwrite -lmfuuid -lole32 -loleaut32 -luuid -lwindowscodecs -lcomdlg32 -lshell32 -lshlwapi -lpropsys -lpsapi -lwinmm \
  -o "build/CRT Genie.exe"
${CROSS}strip "build/CRT Genie.exe"
echo "Built: build/CRT Genie.exe"
