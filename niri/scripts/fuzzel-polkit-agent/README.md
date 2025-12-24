# Fuzzel Polkit Agent

This is a simple shell script which enables
[`fuzzel`](https://codeberg.org/dnkl/fuzzel) to act as authentication agent for
`polkit` requests.

The code is highly inspired by/copied from
[`rofi-polkit-agent`](https://github.com/czaplicki/rofi-polkit-agent)

## Installation

To use this script as `polkit` agent, follow these steps:

- Install all dependencies.
  - `sh` (should be installed on nearly every system)
  - `coreutils` (should be installed on most systems)
  - [`jq`](https://jqlang.github.io/jq/) for parsing JSON code
  - [`fuzzel`](https://codeberg.org/dnkl/fuzzel) (obvious)
  - [`cmd-polkit`](https://github.com/OmarCastro/cmd-polkit?tab=readme-ov-file)
    for interacting with `polkit`
- Clone this repo and place the script in a fitting directory
- Make the script executable with `chmod +x fuzzel-polkit-agent`
- Run the script on startup. E.g. with the init script of your window manager or
  with the `.desktop` entry

## Usage

On most systems you can simply place the `.desktop` file inside your local
autostart folder (using XDG Autostart conventions or `dex`). Otherwise, you can
start the deamon from your init script (`.xinitrc`, `i3`/`sway`/`niri` config
etc.).

When you run the script on startup (or manually from your terminal), it will
stay as background process. Whenever `polkit` triggers a password
authentication, the `fuzzel` prompt will appear and ask for your user password.

By default, it will have the same appearance as your regular fuzzel menu, but
you can pass extra attributes as additional arguments when invoking the script
in your WM init script.

E.g. to highlight the password prompt in red use
`fuzzel-polkit-agent --prompt-color=ff0000ff`. Most regular `fuzzel` commands
can be passed to the agent this way.

## Screenshot

It looks very simple, but does its job:

[![2024-12-30-23-24-36.png](https://i.postimg.cc/L8CQwhdG/2024-12-30-23-24-36.png)](https://postimg.cc/FYSxJrHx)
