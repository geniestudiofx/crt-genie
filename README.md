# CRT Genie

**Free, open-source CRT TV and film look for any video or photo.**
Made by [Genie Studio FX](https://geniestudiofx.github.io/genie-studio/).

![CRT Genie](docs/crt-1.jpg)

| Arcade | VHS |
|---|---|
| ![Arcade](docs/crt-2.jpg) | ![VHS](docs/crt-3.jpg) |

## Download

Get it from the **[website](https://geniestudiofx.github.io/genie-studio/crt-genie.html)**. Windows 10 / 11. It's a single app, no install needed.

> Windows may show a "Windows protected your PC" box because the app isn't code-signed yet. Click **More info → Run anyway**.

# Source code

CRT Genie makes any video or photo look like it was filmed off a real CRT TV, or shot on Super 8 film.
It is a single Windows EXE: OpenGL 3.3 for the effects, Windows Media Foundation for MP4 import/export,
and Dear ImGui for the "broadcast desk" interface.

## Folder layout

| Folder | What's in it |
|---|---|
| `src/main.cpp` | The app: rendering pipeline, grain texture, playback, preview sound, export, settings |
| `src/deck_ui.inl` | The broadcast-desk interface (keys, knobs, displays, banks) |
| `src/media.cpp/.h` | Video/audio decoding and MP4 (H.264 + AAC) encoding via Media Foundation; PNG/JPG via WIC |
| `src/shaders.h` | All GLSL shaders, **generated** by `shaders/gen_shaders.py` (don't edit by hand) |
| `src/font_*.h`, `src/logo_rgba.h`, `src/app.ico` | Embedded fonts and logo, **generated** by `tools/make_assets.py` |
| `shaders/gen_shaders.py` | Builds `src/shaders.h`. The CRT shader is taken from `web/phosphor.html`; the film (Super 8, halation, grain, leaks) and blur shaders live in this script |
| `web/phosphor.html` | The original browser version of the effect (also the source of the CRT shader) |
| `fonts/`, `logo/` | Barlow Semi Condensed, VT323, the CRT Genie logo (SVG + PNG) and icon |
| `third_party/` | Dear ImGui 1.91.9 (MIT) and GLFW 3.4 (zlib) |
| `extras/premiere-plugin/` | The earlier CPU-based Premiere Pro / After Effects effect (needs Adobe's After Effects SDK, which is not included and may not be redistributed) |

## Building

On Linux or Windows with WSL:

```sh
sudo apt install g++-mingw-w64-x86-64-posix
./build.sh
```

The EXE is written to `build/CRT Genie.exe`.

On Windows with MSYS2, run `pacman -S mingw-w64-x86_64-gcc`. Then, from the MINGW64 shell, run `CROSS= ./build.sh`.

If you change a shader, run `python3 shaders/gen_shaders.py` before building.
If you change a font or the logo, run `python3 tools/make_assets.py` (needs `pip install pillow cairosvg`).

## Notes

- Settings are saved to `%APPDATA%\CRT Genie\settings.txt`.
- Exports use the H.264 and AAC encoders built into Windows. HEVC/iPhone clips need the "HEVC Video Extensions" from the Microsoft Store to import.
- Fonts: Barlow Semi Condensed and VT323 are under the SIL Open Font License.

## Licence

MIT — see [LICENSE](LICENSE). Free to use, change and share. Third-party licences are listed in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
