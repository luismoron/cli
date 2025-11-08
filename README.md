# caelestia-cli

The main control script for the Caelestia dotfiles.

<details><summary id="dependencies">External dependencies</summary>

-   [`libnotfy`](https://gitlab.gnome.org/GNOME/libnotify) - sending notifications
-   [`swappy`](https://github.com/jtheoof/swappy) - screenshot editor
-   [`grim`](https://gitlab.freedesktop.org/emersion/grim) - taking screenshots
-   [`dart-sass`](https://github.com/sass/dart-sass) - discord theming
-   [`app2unit`](https://github.com/Vladimir-csp/app2unit) - launching apps
-   [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard) - copying to clipboard
-   [`slurp`](https://github.com/emersion/slurp) - selecting an area
-   [`gpu-screen-recorder`](https://git.dec05eba.com/gpu-screen-recorder/about) - screen recording
-   `glib2` - closing notifications
-   [`cliphist`](https://github.com/sentriz/cliphist) - clipboard history
-   [`fuzzel`](https://codeberg.org/dnkl/fuzzel) - clipboard history/emoji picker

</details>

## Installation

### Prerequisites: Install Hyprland

This dotfiles setup is designed for Hyprland. To install Hyprland on Fedora, enable the COPR repository:

```sh
sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland
```

You may also need additional packages like `hyprpaper`, `hyprlock`, etc., depending on your setup.

### Fedora

The CLI can be installed manually. First, install the dependencies:

```sh
sudo dnf install libnotify swappy grim sassc wl-clipboard slurp glib2 cliphist fuzzel python3-build python3-installer python3-hatch python3-hatch-vcs
```

For `gpu-screen-recorder`, you may need to enable RPM Fusion repositories:

```sh
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install gpu-screen-recorder
```

For `app2unit`, it may not be available in Fedora repositories; check for alternatives or install from source.

### Automated installation

For a fully automated installation, run the provided `install.sh` script:

```sh
chmod +x install.sh
./install.sh
```

This script will enable the necessary repositories, install Hyprland and all dependencies, clone/build/install the CLI, and set up completions.

Then, clone the repo, `cd` into it, build the wheel via `python3 -m build --wheel`
and install it via `python3 -m installer dist/*.whl`. Then, to install the `fish`
completions, copy the `completions/caelestia.fish` file to
`/usr/share/fish/vendor_completions.d/caelestia.fish`.

```sh
git clone https://github.com/caelestia-dots/cli.git
cd cli
python3 -m build --wheel
sudo python3 -m installer dist/*.whl
sudo cp completions/caelestia.fish /usr/share/fish/vendor_completions.d/caelestia.fish
```

## Usage

All subcommands/options can be explored via the help flag.

```
$ caelestia -h
usage: caelestia [-h] [-v] COMMAND ...

Main control script for the Caelestia dotfiles

options:
  -h, --help     show this help message and exit
  -v, --version  print the current version

subcommands:
  valid subcommands

  COMMAND        the subcommand to run
    shell        start or message the shell
    toggle       toggle a special workspace
    scheme       manage the colour scheme
    screenshot   take a screenshot
    record       start a screen recording
    clipboard    open clipboard history
    emoji        emoji/glyph utilities
    wallpaper    manage the wallpaper
    resizer      window resizer daemon
```

## Configuring

All configuration options are in `~/.config/caelestia/cli.json`.

<details><summary>Example configuration</summary>

```json
{
    "record": {
        "extraArgs": []
    },
    "wallpaper": {
        "postHook": "echo $WALLPAPER_PATH"  
    },
    "theme": {
        "enableTerm": true,
        "enableHypr": true,
        "enableDiscord": true,
        "enableSpicetify": true,
        "enableFuzzel": true,
        "enableBtop": true,
        "enableGtk": true,
        "enableQt": true
    },
    "toggles": {
        "communication": {
            "discord": {
                "enable": true,
                "match": [{ "class": "discord" }],
                "command": ["discord"],
                "move": true
            },
            "whatsapp": {
                "enable": true,
                "match": [{ "class": "whatsapp" }],
                "move": true
            }
        },
        "music": {
            "spotify": {
                "enable": true,
                "match": [{ "class": "Spotify" }, { "initialTitle": "Spotify" }, { "initialTitle": "Spotify Free" }],
                "command": ["spicetify", "watch", "-s"],
                "move": true
            },
            "feishin": {
                "enable": true,
                "match": [{ "class": "feishin" }],
                "move": true
            }
        },
        "sysmon": {
            "btop": {
                "enable": true,
                "match": [{ "class": "btop", "title": "btop", "workspace": { "name": "special:sysmon" } }],
                "command": ["foot", "-a", "btop", "-T", "btop", "fish", "-C", "exec btop"]
            }
        },
        "todo": {
            "todoist": {
                "enable": true,
                "match": [{ "class": "Todoist" }],
                "command": ["todoist"],
                "move": true
            }
        }
    }
}
```

</details>
