"""short cut keys"""
from libqtile.config import Click, Drag, Key, KeyChord
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from my_modules.functions import *
from my_modules.global_config import GLOBAL
from my_modules.groups import GROUP_PER_SCREEN

keys = [
    Key([GLOBAL.mod], "Return", lazy.spawn(GLOBAL.terminal), desc="Launch terminal"),
    Key(
        [GLOBAL.mod, "shift"],
        "Return",
        lazy.group["scratchpad"].dropdown_toggle("term"),
        desc="Launch terminal",
    ),
    # Operate window in workspace
    Key([GLOBAL.mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([GLOBAL.mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([GLOBAL.mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([GLOBAL.mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([GLOBAL.mod], "tab", lazy.next_layout(), desc="next layout"),
    Key([GLOBAL.mod, "shift"], "tab", lazy.previous_layout(), desc="previous layout"),
    Key(
        [GLOBAL.mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc="Move window down",
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc="Move window up",
    ),
    Key([GLOBAL.mod, "control"], "c", lazy.window.kill(), desc="Kill focused window"),
    # Operate window between workspaces
    Key(
        [GLOBAL.mod, "control"],
        "h",
        focus_previous_group(),
        keep_pinp(),
        desc="focus prev group",
    ),
    Key(
        [GLOBAL.mod, "control"],
        "l",
        focus_next_group(),
        keep_pinp(),
        desc="focus next group",
    ),
    Key(
        [GLOBAL.mod, "control"],
        "j",
        window_to_previous_group(),
        keep_pinp(),
        desc="window to prev group",
    ),
    Key(
        [GLOBAL.mod, "control"],
        "k",
        window_to_next_group(),
        keep_pinp(),
        desc="window to next group",
    ),
    # Operate floating window
    Key([GLOBAL.mod], "period", float_cycle(forward=True)),
    Key([GLOBAL.mod], "comma", float_cycle(forward=True, focus=True)),
    # Operate screen
    Key([GLOBAL.mod], "n", focus_cycle_screen(), desc="focus next screen"),
    Key([GLOBAL.mod], "p", focus_cycle_screen(backward=True), desc="focus prev screen"),
    Key(
        [GLOBAL.mod, "shift"],
        "n",
        move_cycle_screen(),
        keep_pinp(),
        update_pinp_screen_idx(),
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "p",
        move_cycle_screen(backward=True),
        keep_pinp(),
        update_pinp_screen_idx(),
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "t",
        to_from_display_tablet(),
        keep_pinp(),
        update_pinp_screen_idx(),
    ),
    # Toggle Float and FullScreen
    Key([GLOBAL.mod], "f", lazy.window.toggle_floating()),
    Key([GLOBAL.mod, "shift"], "f", lazy.window.toggle_maximize()),
    Key([GLOBAL.mod, "control", "shift"], "f", lazy.window.toggle_fullscreen()),
    # Exit and Reload
    Key([GLOBAL.mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([GLOBAL.mod, "control"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    # Launch rofi
    Key(
        [GLOBAL.mod],
        "space",
        lazy.spawn("rofi -combi-modi window,drun -show combi"),
        desc="show rofi",
    ),
    Key(
        [GLOBAL.mod, "shift"],
        "space",
        lazy.spawn("rofi -show run"),
        desc="run rofi as shell mode",
    ),
    Key(
        [GLOBAL.mod, "control"],
        "space",
        lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu"),
        desc="show power-menu",
    ),
    # Toggle copyq and calculator
    Key([GLOBAL.mod], "b", lazy.group["scratchpad"].dropdown_toggle("bluetooth")),
    Key([GLOBAL.mod], "m", lazy.group["scratchpad"].dropdown_toggle("volume")),
    Key([GLOBAL.mod], "s", lazy.spawn("copyq toggle")),
    Key(
        [GLOBAL.mod],
        "equal",
        lazy.spawn("rofi -show calc -modi calc -no-show-match -no-sort"),
    ),
    # Lock screen
    Key(
        [GLOBAL.mod, "control"],
        "b",
        lazy.spawn("loginctl lock-session"),
        desc="lock PC",
    ),
    # Screenshot
    Key([], "Print", lazy.spawn("flameshot full -p {}".format(str(GLOBAL.capture_path)))),
    Key([GLOBAL.mod], "Print", capture_screen(is_clipboard=False)),
    Key([GLOBAL.mod, "shift"], "Print", capture_screen(is_clipboard=True)),
    # Function keys
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    ),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPause", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key(
        [],
        "XF86KbdBrightnessUp",
        lazy.spawn("light -Ars {} 1".format("sysfs/leds/asus::kbd_backlight")),
    ),
    Key(
        [],
        "XF86KbdBrightnessDown",
        lazy.spawn("light -Urs {} 1".format("sysfs/leds/asus::kbd_backlight")),
    ),
    Key([], "XF86Launch1", lazy.spawn('sh -c "/home/sumi/bin/swich_gpu_mode"')),
    Key([], "XF86Launch4", lazy.spawn("asusctl profile -n")),
    # Attach Screen
    KeyChord(
        [GLOBAL.mod],
        "a",
        [
            Key([], "k", attach_screen("above")),
            Key([], "j", attach_screen("below")),
            Key([], "l", attach_screen("right-of")),
            Key([], "h", attach_screen("left-of")),
            Key([], "d", attach_screen("delete")),
            Key([], "space", lazy.ungrab_chord()),
        ],
        name="attach",
    ),
    # PinP operationes
    KeyChord(
        [GLOBAL.mod],
        "v",
        [
            Key([], "k", move_pinp("up")),
            Key([], "j", move_pinp("down")),
            Key([], "l", move_pinp("right")),
            Key([], "h", move_pinp("left")),
            Key([], "f", force_pinp()),
            Key([], "space", lazy.ungrab_chord()),
        ],
        name="pinp",
    ),
]

for i in range(GROUP_PER_SCREEN):
    keys.extend(
        [
            Key(
                [GLOBAL.mod],
                str(i + 1),
                focus_n_screen_group(i),
                keep_pinp,
                desc="Switch to group idx {}".format(i + 1),
            ),
            Key(
                [GLOBAL.mod, "shift"],
                str(i + 1),
                move_n_screen_group(i),
                keep_pinp,
                desc="Switch to & move focused window to group idx {}".format(i + 1),
            ),
        ]
    )

# Drag floating layouts.
mouse = [
    Drag(
        [GLOBAL.mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [GLOBAL.mod, "shift"],
        "Button1",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
]
