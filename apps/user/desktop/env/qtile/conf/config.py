"""config.py"""

from libqtile.log_utils import logger

from my_modules import groups, keymap, screens, startup, wallpaper
from my_modules import layouts as my_layouts
from my_modules.functions import set_mouse
from my_modules.variables import GlobalConf, set_bar_default

groups = groups.set_groups()
layouts = my_layouts.set_layouts()
floating_layout = my_layouts.set_floating_layout()
screens = screens.make_screens()
keys = keymap.set_keys()
mouse = set_mouse()

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
