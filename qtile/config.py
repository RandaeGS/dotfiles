# Imports #
import os
import subprocess
import json
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Defaults #
mod = "mod4"
terminal = "kitty"
browser = "firefox"

keys = [
   # Switch between screens
   Key([mod], "period", lazy.next_screen(), desc="Move to the next screen"),

   # Switch between windows
   Key([mod], "j", lazy.layout.left(), desc="Move focus to left"),
   Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
   Key([mod], "k", lazy.layout.down(), desc="Move focus down"),
   Key([mod], "i", lazy.layout.up(), desc="Move focus up"),
   Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
   # Move windows between left/right columns or move up/down in current stack.
   # Moving out of range in Columns layout will create new column.
   Key([mod, "shift"], "j", lazy.layout.shuffle_left(), desc="Move window to the left"),
   Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
   Key([mod, "shift"], "k", lazy.layout.shuffle_down(), desc="Move window down"),
   Key([mod, "shift"], "i", lazy.layout.shuffle_up(), desc="Move window up"),

   # Toggle between different layouts as defined below
   Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
   Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
   Key([mod],"f",lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
   Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
   Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

   # Volume control #
   Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Raise volume"),
   Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Lower volume"),
   Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle volume"),

   # Applications Shortcuts # 
   Key([mod], "Return", lazy.spawn(terminal), desc="Launch kitty terminal"),
   Key([mod], "b", lazy.spawn(browser), desc="Launch firefox"),
   Key([mod], "x", lazy.spawn("thunar"), desc="Launch thunar"),
   Key([mod], "Backspace", lazy.spawn("rofi -show combi"), desc="Lauch Rofi"),
]

groups = [Group(i) for i in "123456"]


for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
               [mod],
               i.name,
               lazy.group[i.name].toscreen(),
               desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
               [mod, "shift"],
               i.name,
               lazy.window.togroup(i.name, switch_group=False),
               desc="Switch window to group {}".format(i.name),
            ),
        ]
    )


# Layouts #
layout_theme = {
   "border_width": 3,
   "margin": 6,
   "border_focus": "#28439e"
}

layouts = [
   layout.MonadTall(**layout_theme),
   layout.Max()
]

# Bar #
widget_defaults = dict(
   font="Noto Sans",
   fontsize=13,
   padding=3,
)
extension_defaults = widget_defaults.copy()

def volumeControl():
   qtile.cmd_spawn("pavucontrol")

def toggleVolume():
   lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", desc="Toggle audio")

screens = [
	Screen(
		top=bar.Bar(
			[
			widget.GroupBox(highlight_method="block"),
			widget.WindowTabs(),
         widget.TextBox(
            text='',
            background="#232136", #Va del color de la barra
            foreground="#f6c177",
            padding=0,
            fontsize=42
         ),
			widget.TextBox(
            text=' ',
            background="#f6c177",
            foreground="#191724",
            padding=7
         ),
         widget.CurrentLayout(
            background="#f6c177",
            foreground="#191724"
         ),
         widget.TextBox(
            text='',
            background="#f6c177",
            foreground="#9ccfd8",
            padding=0,
            fontsize=42
         ),
         widget.Volume(
            background="#9ccfd8",
            foreground="191724",
            mouse_callbacks = {"Button1": volumeControl, "Button2": toggleVolume}
         ),
         widget.TextBox(
            text='',
            background="#9ccfd8",
            foreground="#edf2fa",
            padding=0,
            fontsize=42
         ),
			widget.Clock(
            background="#edf2fa",
            foreground="#191724",
            format="🕗 %H:%M - %d/%m %a",
            update_interval = 60.0
         ),
			],
			25,
         background="#232136",
		),
		# x11_drag_polling_rate = 60,
	),
	Screen(
		top=bar.Bar(
			[
			widget.GroupBox(highlight_method="block"),
			widget.WindowTabs(),
			widget.Systray(),
         widget.TextBox(
            text='',
            background="#232136", #Va del color de la barra
            foreground="#f6c177",
            padding=0,
            fontsize=42
         ),
			widget.TextBox(
            text=' ',
            background="#f6c177",
            foreground="#191724",
            padding=7
         ),
         widget.CurrentLayout(
            background="#f6c177",
            foreground="#191724"
         ),
         widget.TextBox(
            text='',
            background="#f6c177",
            foreground="#9ccfd8",
            padding=0,
            fontsize=42
         ),
			widget.Notify(default_timeout=5),
         widget.Volume(
            background="#9ccfd8",
            foreground="191724",
            fmt=" {}",
            mouse_callbacks = {"Button1": volumeControl, "Button2": toggleVolume}
         ),
         widget.TextBox(
            text='',
            foreground="#eb6f92",
            background="#9ccfd8",
            padding=0,
            fontsize=42
         ),
         widget.Memory(
            format="{MemUsed: .0f}{mm}",
            background="#eb6f92",
            foreground="#191724",
            interval=1.0
         ),
         widget.TextBox(
            text='',
            background="#eb6f92",
            foreground="#edf2fa",
            padding=0,
            fontsize=42
         ),
			widget.Clock(
            background="#edf2fa",
            foreground="#191724",
            format="\u23F1 %A %d/%m %H:%M",
            update_interval = 60.0
         )
			],
			25,
         background="#232136",
		)
   )
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True # Cursor follows movement #
floating_layout = layout.Floating(
   float_rules=[
      # Run the utility of `xprop` to see the wm class and name of an X client.
      *layout.Floating.default_float_rules,
      Match(wm_class="confirmreset"),  # gitk
      Match(wm_class="makebranch"),  # gitk
      Match(wm_class="maketag"),  # gitk
      Match(wm_class="ssh-askpass"),  # ssh-askpass
      Match(title="branchdialog"),  # gitk
      Match(title="pinentry"),  # GPG key password entry
   ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# Startup don't forget to chmod +x autostart.h#
@hook.subscribe.startup_once
def autostart():
   home = os.path.expanduser('~/.config/qtile/autostart.sh')
   subprocess.run([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
