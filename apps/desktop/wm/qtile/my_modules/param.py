"""This is paramater"""
import os
import dataclasses
from pathlib import Path

from libqtile.log_utils import logger


@dataclasses.dataclass
class Param:
    laptop = 'sumi-zephyrus' == os.uname()[1]

    mod = 'mod4' # super key
    terminal = 'kitty'

    home = Path.home()
    capture_path = home.joinpath('Pictures', 'screenshot')
    wallpapers = list(home.joinpath('Pictures', 'wallpapers').glob('*.jpg'))
    wallpapers.sort()

    num_screen = 2

    border = 2

    pinp_scale_down = 3.2
    pinp_margin = 3 + border

    margin = 10
    gaps = 15

    slice_width = 350 if laptop else 500

    font = 'Noto Sans CJK JP'
    font_size = 18

    bar_font_size = 28

    is_display_tablet = False

    c_normal = {
        'BGbase': '#222d32', 'FGbase': '#475359',
        'black': '#01060e', 'red': '#ff5252',
        'green': '#4db69f', 'yellow': '#c9bc0e',
        'blue': '#008fc2', 'magenta': '#cf00ac',
        'cyan': '#02adc7', 'white': '#cfd8dc',
        'clear': '#00000000'
        }
    c_bright = {
        'bblack': "#475359", 'bred': "#ff4f4d",
        'bgreen': "#56d6ba", 'byellow': "#c9c30e",
        'bblue': "#c9c30e", 'bmagenta': "#9c0082",
        'bcyan': "#02b7c7", 'bwhite': "#a7b0b5"
        }


    dgroups_key_binder = None
    dgroups_app_rules = []  # type: list
    follow_mouse_focus = False
    bring_front_click = 'floating_only'
    cursor_warp = False
    auto_fullscreen = True
    focus_on_window_activation = 'smart'
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
    wmname = 'LG3D'

PARAM = Param()
