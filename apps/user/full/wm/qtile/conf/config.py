"""config.py"""
from my_modules.global_config import GLOBAL

from my_modules.groups import groups
from my_modules.bar import mybar_default, extension_defaults
from my_modules.keymap import keys, mouse
from my_modules.layouts import floating_layout
from my_modules.make_screens import screens
from my_modules.wallpaper import *
from my_modules.startup import *

from libqtile.log_utils import logger

dgroups_key_binder = GLOBAL.dgroups_key_binder
dgroups_app_rules = GLOBAL.dgroups_app_rules
follow_mouse_focus = GLOBAL.follow_mouse_focus
bring_front_click = GLOBAL.bring_front_click
cursor_warp = GLOBAL.cursor_warp
auto_fullscreen = GLOBAL.auto_fullscreen
focus_on_window_activation = GLOBAL.focus_on_window_activation
reconfigure_screens = GLOBAL.reconfigure_screens
auto_minimize = GLOBAL.auto_minimize
wmname = GLOBAL.wmname