# sddmstyler

A small command-line tool that changes the SDDM login-screen wallpaper
system-wide, on any SDDM theme, for all users — and does it interactively.

You type the command, paste a wallpaper file path, enter your sudo password,
and it's applied. No theme editing by hand.

## Requirements

- Linux with [SDDM](https://github.com/sddm/sddm)
- `bash`, `awk`, `grep`, `sed`, `install` (all found on every distro)

## Install

Install straight from the repository (downloads the latest version from GitHub):

```sh
sudo ./install.sh                                          # from a clone
curl -fsSL https://raw.githubusercontent.com/veo47/sddmstyler/main/install.sh | sudo sh
```

Or manually, from the repo folder:

```sh
install -m 755 sddmstyler /usr/local/bin/sddmstyler
```

## Usage

```sh
sddmstyler                       # interactive: prompts for wallpaper path + password
sddmstyler -f ~/Pictures/wall.jpg
sddmstyler -f ~/Pictures/wall.jpg -n ocean
sddmstyler -f ~/Pictures/bg.mp4 -t my-theme
```

Options:

| Option | Description |
| --- | --- |
| `-f, --file <path>` | Local wallpaper image or video file (skips the prompt) |
| `-n, --name <name>` | Base name used inside the theme (default: `custom`) |
| `-t, --theme <name>` | SDDM theme to modify (skips auto-detection) |
| `-a, --absolute` | Reference the wallpaper by absolute path (`/usr/share/wallpapers`) instead of storing it in the theme |
| `-h, --help` | Show help |

After it runs, preview with `sddm-greeter --test --theme <theme dir>` and apply
it by logging out (or `sudo systemctl restart sddm`).

## Supported wallpaper files

- Images: `.jpg` `.jpeg` `.png` `.webp` `.gif` `.bmp`
- Video: `.mp4` `.webm` `.mkv` `.mov` `.m4v`

## How it works

1. Detects the active SDDM theme from `/etc/sddm.conf` / `/etc/sddm.conf.d/*.conf`.
2. Locates the theme directory (system themes, user themes, distro themes).
3. Copies the wallpaper into the theme's `backgrounds/` folder (or
   `/usr/share/wallpapers` for themes without one).
4. Rewrites the background key in the theme's configuration:
   - `configs/*.conf` themes (e.g. SilentSDDM)
   - `theme.conf` / `theme.conf.user`
5. Handles the common background key spellings:
   `background`, `Background`, `Wallpaper`, `BackgroundPath`, `Image`.

Scaffolding it re-runs system-wide for every user because the greeter (SDDM)
reads the theme files directly — no per-user settings involved.

## Compatibility

Works out of the box with config-driven themes such as **Silent / SilentSDDM,
Breeze, Monochrome, QTStep, Apple-Sonoma** and most others that store their
background in `theme.conf`.

Not supported: themes that hard-code their background inside `Main.qml`
(no config key) or use only a solid color.

## Development

```sh
bash -n sddmstyler                    # syntax check
shellcheck sddmstyler                 # static analysis (if installed)
```

Testing against a copied theme without root:

```sh
SDDM_THEME_DIR=/tmp/mytheme SDDM_THEME_NAME=mytheme \
  ./sddmstyler -f /path/to/wall.jpg
```

## License

[MIT](LICENSE)