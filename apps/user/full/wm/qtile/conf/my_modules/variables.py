"""This is Global config"""

import os
from dataclasses import dataclass, field
from pathlib import Path
from typing import Union

from libqtile import qtile
from libqtile.log_utils import logger


@dataclass
class FontConfig:
    font: str = "Moralerspace Neon NF"
    fontsize: int = 15


@dataclass
class BarConfig:
    size: int = 28
    border_width: int = 0
    top_bar_margin: Union[int, list[int]] = field(default_factory=lambda: [10, 20, 5, 20])
    bottom_bar_margin: Union[int, list[int]] = field(default_factory=lambda: [5, 10, 5, 10])
    opacity: int = 1


@dataclass
class PinPConfig:
    scale_down: float = 3.2
    margin: int = 3
    target_cls_name: list[str] = field(
        default_factory=lambda: [
            "Picture in picture",
            "ピクチャー イン ピクチャー",
            "Picture-in-Picture",
            "mpv",
        ]
    )


@dataclass
class WindowConfig:
    border: int = 2
    margin: int = 10


@dataclass
class Global:
    laptop = os.uname()[1] in ["zephyrus"]
    under_fhd = os.uname()[1] in ["zephyrus", "stacia"]
    vm = "general" == os.uname()[1]
    mod = "mod1"  # super key is 'mod4', alt is 'mod1'
    terminal = "wezterm"
    terminal_class = "org.wezfurlong.wezterm"

    home = Path.home()
    capture_path = home.joinpath("Pictures", "screenshot")
    if not capture_path.exists():
        os.mkdir(capture_path)
    if laptop or vm:
        wallpapers = list(home.joinpath("Pictures", "wallpapers", "fixed").glob("*.png"))
    else:
        wallpapers = list(home.joinpath("Pictures", "wallpapers", "unfixed").glob("*.png"))
    wallpapers.sort()
    screen_saver = str(home.joinpath("Pictures", "wallpapers", "screen_saver.png"))
    num_screen = 1 if os.uname()[1] == "vm" else 2

    is_display_tablet = True if os.uname()[1] in ["mother"] else False

    dgroups_key_binder = None
    dgroups_app_rules = []  # type: list
    follow_mouse_focus = False
    bring_front_click = "floating_only"
    cursor_warp = False
    auto_fullscreen = True
    focus_on_window_activation = "smart"
    reconfigure_screens = True

    # If things like steam games want to auto-minimize themselves when losing
    # focus, should we respect this or not?
    auto_minimize = True

    # XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
    # string besides java UI toolkits; you can see several discussions on the
    # mailing lists, GitHub issues, and other WM documentation that suggest setting
    # this string if your java app doesn't work correctly. We may as well just lie
    # and say that we're a working one by default.
    #
    # We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
    # java that happens to be on java's whitelist.
    wmname = "LG3D"


PinPConf = PinPConfig()
FontConf = FontConfig()
BarConf = BarConfig()
WindowConf = WindowConfig()
GlobalConf = Global()
