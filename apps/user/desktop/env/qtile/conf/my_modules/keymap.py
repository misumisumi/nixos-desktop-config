"""short cut keys"""

from libqtile.config import Drag, Key, KeyChord
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from my_modules import functions as F
from my_modules.groups import GROUP_PER_SCREEN
from my_modules.variables import GlobalConf


def set_keys():
    def _set_keys(mod: str):
        _keys = [
            Key([mod], "Return", lazy.spawn(GlobalConf.terminal), desc="Launch terminal"),
            Key(
                [mod, "shift"],
                "Return",
                lazy.group["scratchpad"].dropdown_toggle("term"),
                desc="Launch terminal",
            ),
            # Operate window in workspace
            Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
            Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
            Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
            Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
            Key([mod], "Tab", lazy.next_layout(), desc="next layout"),
            Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="previous layout"),
            Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
            Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
            Key(
                [mod, "shift"],
                "j",
                lazy.layout.shuffle_down(),
                lazy.layout.section_down(),
                desc="Move window down",
            ),
            Key([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(), desc="Move window up"),
            Key([mod, "control"], "c", lazy.window.kill(), desc="Kill focused window"),
            # Operate window between workspaces
            Key([mod, "control"], "h", F.focus_previous_group(), F.keep_pinp(), desc="focus prev group"),
            Key([mod, "control"], "l", F.focus_next_group(), F.keep_pinp(), desc="focus next group"),
            Key([mod, "control"], "j", F.window_to_previous_group(), F.keep_pinp(), desc="window to prev group"),
            Key([mod, "control"], "k", F.window_to_next_group(), F.keep_pinp(), desc="window to next group"),
            # Operate floating window
            Key([mod], "period", F.float_cycle(forward=True)),
            Key([mod], "comma", F.float_cycle(forward=True, focus=True)),
            # Operate screen
            Key([mod], "n", F.focus_cycle_screen(), desc="focus next screen"),
            Key([mod], "p", F.focus_cycle_screen(backward=True), desc="focus prev screen"),
            Key(
                [mod, "shift"],
                "n",
                F.move_cycle_screen(),
                F.keep_pinp(),
                F.update_pinp_screen_idx(),
            ),
            Key(
                [mod, "shift"],
                "p",
                F.move_cycle_screen(backward=True),
                F.keep_pinp(),
                F.update_pinp_screen_idx(),
            ),
            # Toggle Float and FullScreen
            Key([mod], "f", lazy.window.toggle_floating()),
            Key([mod, "shift"], "f", lazy.window.toggle_maximize()),
            Key([mod, "control", "shift"], "f", lazy.window.toggle_fullscreen()),
            # Exit and Reload
            Key([mod, "control"], "r", F.reload_config_alt(), desc="Reload the config"),
            Key([mod, "control", "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
            # Launch rofi
            Key([mod], "space", lazy.spawn("rofi -show combi"), desc="show rofi"),
            Key([mod, "shift"], "space", lazy.spawn("rofi -show run"), desc="run rofi as shell mode"),
            Key(
                [mod, "control"],
                "space",
                lazy.spawn("rofi -modi power-menu:rofi-power-menu -show power-menu "),
                desc="show power-menu",
            ),
            Key([mod], "equal", lazy.spawn("rofi -show calc -modi calc -no-show-match -no-sort")),
            Key([mod], "e", lazy.spawn("rofimoji"), desc="show rofimoji by default config"),
            Key([mod, "control"], "e", lazy.spawn("rofimoji -f nerd"), desc="show rofimoji for searting nerd"),
            # Toggle application
            Key([mod], "b", lazy.group["scratchpad"].dropdown_toggle("bluetooth")),
            Key([mod], "m", lazy.group["scratchpad"].dropdown_toggle("volume")),
            Key([mod], "s", lazy.spawn("copyq toggle")),
            # dunst
            Key(["shift"], "space", lazy.spawn("dunstctl context")),
            Key([mod, "control"], "semicolon", lazy.spawn("dunstctl close-all")),
            Key([mod, "shift"], "semicolon", lazy.spawn("dunstctl history-pop")),
            Key([mod], "semicolon", lazy.spawn("dunstctl close")),
            # Lock screen
            Key([mod, "control"], "b", lazy.spawn("loginctl lock-session"), desc="lock PC"),
            # Screenshot
            Key([], "Print", lazy.spawn("flameshot full")),
            Key(["shift"], "Print", lazy.spawn("flameshot full -c")),
            Key(["shift", "control"], "Print", lazy.spawn("flameshot gui")),
            Key([mod], "Print", F.capture_screen(is_clipboard=False)),
            Key([mod, "shift"], "Print", F.capture_screen(is_clipboard=True)),
            # Function keys
            Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
            Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
            Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
            Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")),
            Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause -a")),
            Key([], "XF86AudioPause", lazy.spawn("playerctl play-pause -a")),
            Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
            Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
            # PinP operationes
            KeyChord(
                [mod],
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

        if GlobalConf.pentablet is not None:
            _keys += [
                Key([mod], "t", F.focus_cycle_screen(pentablet=True), desc="forcus pentablet"),
                Key(
                    [mod, "shift"],
                    "t",
                    F.to_from_pentablet(),
                    F.keep_pinp(),
                    F.update_pinp_screen_idx(),
                    desc="move window to pentablet",
                ),
            ]
        if GlobalConf.laptop:
            _keys += [
                Key([], "XF86MonBrightnessUp", lazy.spawn("brillo -A 5")),
                Key([], "XF86MonBrightnessDown", lazy.spawn("brillo -U 5")),
                Key([], "XF86KbdBrightnessUp", lazy.spawn("brillo -kr -A 1")),
                Key([], "XF86KbdBrightnessDown", lazy.spawn("brillo -kr -U 1")),
                Key(
                    [],
                    "XF86Launch4",
                    lazy.spawn(
                        "sh -c \"asusctl profile -n && dunstify -h string:x-dunst-stack-tag:asusctl -a asusctl $(asusctl profile -p | tail -n1 | awk -F' ' '{print $4}')\""
                    ),
                ),
                # Attach Screen
                KeyChord(
                    [mod],
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
            _keys += [
                Key(
                    [mod],
                    str(i + 1),
                    F.focus_n_screen_group(i),
                    F.keep_pinp,
                    desc=f"Switch to group idx {i + 1}",
                ),
                Key(
                    [mod, "shift"],
                    str(i + 1),
                    F.move_n_screen_group(i),
                    F.keep_pinp,
                    desc=f"Switch to & move focused window to group idx {i + 1}",
                ),
            ]

        return _keys

    keys = _set_keys(GlobalConf.mod)
    sub_mod_chord = KeyChord(
        [GlobalConf.mod],
        "z",
        _set_keys(GlobalConf.sub_mod)
        + [
            Key([GlobalConf.sub_mod], "z", lazy.ungrab_chord()),
        ],
        mode=True,
        name="mod4",
    )
    # remove escape mapping to use is as a normal key when using apps that use various alts such as blender.
    sub_mod_chord.submappings.pop(-1)
    keys += [sub_mod_chord]

    return keys
