"""short cut keys"""

from libqtile.config import Drag, Key, KeyChord
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from my_modules import functions as F
from my_modules.groups import GROUP_PER_SCREEN
from my_modules.variables import GlobalConf


def set_keys():
    keys = [
        Key([GlobalConf.mod], "Return", lazy.spawn(GlobalConf.terminal), desc="Launch terminal"),
        Key(
            [GlobalConf.mod, "shift"],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle("term"),
            desc="Launch terminal",
        ),
        # Operate window in workspace
        Key([GlobalConf.mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([GlobalConf.mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([GlobalConf.mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([GlobalConf.mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([GlobalConf.mod], "tab", lazy.next_layout(), desc="next layout"),
        Key([GlobalConf.mod, "shift"], "tab", lazy.previous_layout(), desc="previous layout"),
        Key(
            [GlobalConf.mod, "shift"],
            "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [GlobalConf.mod, "shift"],
            "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [GlobalConf.mod, "shift"],
            "j",
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc="Move window down",
        ),
        Key(
            [GlobalConf.mod, "shift"],
            "k",
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc="Move window up",
        ),
        Key([GlobalConf.mod, "control"], "c", lazy.window.kill(), desc="Kill focused window"),
        # Operate window between workspaces
        Key(
            [GlobalConf.mod, "control"],
            "h",
            F.focus_previous_group(),
            F.keep_pinp(),
            desc="focus prev group",
        ),
        Key(
            [GlobalConf.mod, "control"],
            "l",
            F.focus_next_group(),
            F.keep_pinp(),
            desc="focus next group",
        ),
        Key(
            [GlobalConf.mod, "control"],
            "j",
            F.window_to_previous_group(),
            F.keep_pinp(),
            desc="window to prev group",
        ),
        Key(
            [GlobalConf.mod, "control"],
            "k",
            F.window_to_next_group(),
            F.keep_pinp(),
            desc="window to next group",
        ),
        # Operate floating window
        Key([GlobalConf.mod], "period", F.float_cycle(forward=True)),
        Key([GlobalConf.mod], "comma", F.float_cycle(forward=True, focus=True)),
        # Operate screen
        Key([GlobalConf.mod], "n", F.focus_cycle_screen(), desc="focus next screen"),
        Key([GlobalConf.mod], "p", F.focus_cycle_screen(backward=True), desc="focus prev screen"),
        Key(
            [GlobalConf.mod, "shift"],
            "n",
            F.move_cycle_screen(),
            F.keep_pinp(),
            F.update_pinp_screen_idx(),
        ),
        Key(
            [GlobalConf.mod, "shift"],
            "p",
            F.move_cycle_screen(backward=True),
            F.keep_pinp(),
            F.update_pinp_screen_idx(),
        ),
        # Toggle Float and FullScreen
        Key([GlobalConf.mod], "f", lazy.window.toggle_floating()),
        Key([GlobalConf.mod, "shift"], "f", lazy.window.toggle_maximize()),
        Key([GlobalConf.mod, "control", "shift"], "f", lazy.window.toggle_fullscreen()),
        # Exit and Reload
        Key([GlobalConf.mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([GlobalConf.mod, "control", "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        # Launch rofi
        Key([GlobalConf.mod], "space", lazy.spawn("rofi -show"), desc="show rofi"),
        Key([GlobalConf.mod, "shift"], "space", lazy.spawn("rofi -show run"), desc="run rofi as shell mode"),
        Key(
            [GlobalConf.mod, "control"],
            "space",
            lazy.spawn("rofi -modi power-menu:rofi-power-menu -show power-menu "),
            desc="show power-menu",
        ),
        Key(
            [GlobalConf.mod],
            "equal",
            lazy.spawn("rofi -show calc -modi calc -no-show-match -no-sort"),
        ),
        Key([GlobalConf.mod], "e", lazy.spawn("rofi -modi emoji -show emoji"), desc="show rofi-emoji"),
        # Toggle application
        Key([GlobalConf.mod], "b", lazy.group["scratchpad"].dropdown_toggle("bluetooth")),
        Key([GlobalConf.mod], "m", lazy.group["scratchpad"].dropdown_toggle("volume")),
        Key([GlobalConf.mod], "s", lazy.spawn("copyq toggle")),
        # Lock screen
        Key(
            [GlobalConf.mod, "control"],
            "b",
            lazy.spawn("loginctl lock-session"),
            desc="lock PC",
        ),
        # Screenshot
        Key([], "Print", lazy.spawn("flameshot full")),
        Key(["shift"], "Print", lazy.spawn("flameshot full -c")),
        Key(["shift", "control"], "Print", lazy.spawn("flameshot gui")),
        Key([GlobalConf.mod], "Print", F.capture_screen(is_clipboard=False)),
        Key([GlobalConf.mod, "shift"], "Print", F.capture_screen(is_clipboard=True)),
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
            lazy.spawn("light -Ars sysfs/leds/asus::kbd_backlight 1"),
        ),
        Key(
            [],
            "XF86KbdBrightnessDown",
            lazy.spawn("light -Urs sysfs/leds/asus::kbd_backlight 1"),
        ),
        # Key([], "XF86Launch1", lazy.spawn('sh -c "/home/sumi/bin/swich_gpu_mode"')),
        Key([], "XF86Launch4", lazy.spawn("asusctl profile -n")),
        # PinP operationes
        KeyChord(
            [GlobalConf.mod],
            "v",
            [
                Key([], "k", F.move_pinp("up")),
                Key([], "j", F.move_pinp("down")),
                Key([], "l", F.move_pinp("right")),
                Key([], "h", F.move_pinp("left")),
                Key([], "f", F.force_pinp()),
                Key([], "space", lazy.ungrab_chord()),
            ],
            name="pinp",
        ),
    ]

    if GlobalConf.has_pentablet:
        keys += [
            Key([GlobalConf.mod], "t", F.focus_cycle_screen(pentablet=True), desc="forcus pentablet"),
            Key(
                [GlobalConf.mod, "shift"],
                "t",
                F.to_from_pentablet(),
                F.keep_pinp(),
                F.update_pinp_screen_idx(),
                desc="move window to pentablet",
            ),
        ]
    if GlobalConf.laptop:
        keys += [
            # Attach Screen
            KeyChord(
                [GlobalConf.mod],
                "a",
                [
                    Key([], "k", F.attach_screen("above")),
                    Key([], "j", F.attach_screen("below")),
                    Key([], "l", F.attach_screen("right-of")),
                    Key([], "h", F.attach_screen("left-of")),
                    Key([], "d", F.attach_screen("delete")),
                    Key([], "r", F.reload_screens()),
                    Key([], "space", lazy.ungrab_chord()),
                ],
                name="attach",
            ),
        ]

    for i in range(GROUP_PER_SCREEN):
        keys.extend(
            [
                Key(
                    [GlobalConf.mod],
                    str(i + 1),
                    F.focus_n_screen_group(i),
                    F.keep_pinp,
                    desc=f"Switch to group idx {i+1}",
                ),
                Key(
                    [GlobalConf.mod, "shift"],
                    str(i + 1),
                    F.move_n_screen_group(i),
                    F.keep_pinp,
                    desc=f"Switch to & move focused window to group idx {i+1}",
                ),
            ]
        )

    return keys


def set_mouse():
    # Drag floating layouts.
    return [
        Drag(
            [GlobalConf.mod],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [GlobalConf.mod, "shift"],
            "Button1",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
    ]
