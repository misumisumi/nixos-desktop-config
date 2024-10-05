"""This is Global config"""

import configparser
import os
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional, Union

from libqtile.log_utils import logger
from xdg import BaseDirectory

from my_modules import utils
from my_modules.colorset import ColorSet


@dataclass
class FontConfig:
    font: str = "Moralerspace Neon NF"
    fontsize: int = 16


@dataclass
class IconConfig:
    icon_size: int = 16
    icon_theme: Optional[str] = None

    def __post_init__(self):
        gtk = configparser.ConfigParser()
        gtk.read(Path.home().joinpath(".config/gtk-4.0/settings.ini"))
        if gtk.has_option("Settings", "gtk-icon-theme-name"):
            self.icon_theme = gtk.get("Settings", "gtk-icon-theme-name")


@dataclass
class BarConfig:
    size: int = 28
    border_width: int = 0
    top_bar_margin: Union[int, list[int]] = field(default_factory=lambda: [10, 20, 0, 20])
    bottom_bar_margin: Union[int, list[int]] = field(default_factory=lambda: [0, 10, 5, 10])
    opacity: int = 1


@dataclass
class PinPConfig:
    scale_down: float = 3.2
    margin: int = 3
    pinp_scale_down: float = 3.2
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
    monitors: int = 1
    laptop: bool = Path("/sys/class/power_supply/BAT0").exists()

    mod: str = "mod1"  # super key is 'mod4', alt is 'mod1'
    terminal: str = "wezterm"
    terminal_class: str = "org.wezfurlong.wezterm"

    home: Path = Path.home()
    wallpapers_path: Path = Path(os.getenv("XDG_PICTURES_DIR")).joinpath("wallpapers")
    wallpapers_cache_path: Path = Path(BaseDirectory.save_cache_path("qtile/wallpapers"))
    wallpapers: list[str] = field(init=False)
    cached_wallpapers: list[str] = field(default_factory=lambda: [])
    use_cached_wallpapers: bool = True

    has_pentablet: bool = True if os.uname()[1] in ["mother"] else False

    auto_fullscreen: bool = True
    bring_front_click: str = "floating_only"
    cursor_warp: bool = False
    dgroups_app_rules: list = field(default_factory=lambda: [])
    dgroups_key_binder: Optional = field(default_factory=lambda: None)
    focus_on_window_activation: str = "smart"
    follow_mouse_focus: bool = False
    reconfigure_screens: bool = False
    # If things like steam games want to auto-minimize themselves when losing
    # focus, should we respect this or not?
    auto_minimize: bool = True

    # XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
    # string besides java UI toolkits; you can see several discussions on the
    # mailing lists, GitHub issues, and other WM documentation that suggest setting
    # this string if your java app doesn't work correctly. We may as well just lie
    # and say that we're a working one by default.
    #
    # We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
    # java that happens to be on java's whitelist.
    wmname: str = "LG3D"

    def __post_init__(self):
        self.wallpapers = utils.get_wallpapers(self.wallpapers_path, self.laptop)
        self.update_monitors()

    def update_monitors(self):
        self.monitors = utils.get_n_monitors(self.has_pentablet)


FontConf = FontConfig()
IconConf = IconConfig()
BarConf = BarConfig()
PinPConf = PinPConfig()
WindowConf = WindowConfig()
GlobalConf = Global()


def set_bar_default():
    default_background = {
        "colour": ColorSet.transparent,
        "radius": 5,
        "filled": True,
        "padding_y": 0,
        "padding_x": 0,
        "group": True,
        "use_widget_background": True,
    }
    widget_defaults = dict(
        font=FontConf.font,
        background=ColorSet.background,
        foreground=ColorSet.foreground,
        fontsize=FontConf.fontsize,
        padding_x=0,
        padding_y=0,
        # decorations=[widget.decorations.RectDecoration(**default_background)],
    )

    extension_defaults = widget_defaults.copy()

    return default_background, widget_defaults, extension_defaults
