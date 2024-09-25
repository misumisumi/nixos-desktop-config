"""config.py"""

from libqtile.log_utils import logger

from my_modules import startup, wallpaper
from my_modules.groups import groups
from my_modules.keymap import keys, mouse
from my_modules.layouts import floating_layout
from my_modules.screen import make_screens
from my_modules.variables import GlobalConf, set_bar_default

screens = make_screens()

dgroups_key_binder = GlobalConf.dgroups_key_binder
dgroups_app_rules = GlobalConf.dgroups_app_rules
follow_mouse_focus = GlobalConf.follow_mouse_focus
bring_front_click = GlobalConf.bring_front_click
cursor_warp = GlobalConf.cursor_warp
auto_fullscreen = GlobalConf.auto_fullscreen
focus_on_window_activation = GlobalConf.focus_on_window_activation
reconfigure_screens = GlobalConf.reconfigure_screens
auto_minimize = GlobalConf.auto_minimize
wmname = GlobalConf.wmname
default_background, widget_defaults, extension_defaults = set_bar_default()
