"""set wallpaper"""

import subprocess

from libqtile import hook, qtile
from libqtile.log_utils import logger

from my_modules.groups import _group_and_rule
from my_modules.variables import GlobalConf

MONITOR0 = 0
MONITOR1 = 0
MONITOR2 = 0

# 壁紙の割当


@hook.subscribe.setgroup
def change_wallpaper():
    if len(qtile.screens) == 3:
        global MONITOR0
        global MONITOR1
        global MONITOR2
        group = qtile.current_screen.group
        gidx = qtile.groups.index(group)
        if qtile.current_screen in qtile.screens:
            idx = qtile.screens.index(qtile.current_screen)
            n_groups = len(_group_and_rule)
            if gidx >= n_groups:
                gidx -= n_groups * idx
            if idx == 0:
                MONITOR0 = gidx
            elif idx == 1:
                MONITOR1 = gidx
            subprocess.run(
                "feh --bg-fill {} --bg-fill {} --bg-fill {}".format(
                    str(GlobalConf.wallpapers[MONITOR0]),
                    str(GlobalConf.wallpapers[MONITOR1]),
                    str(GlobalConf.wallpapers[MONITOR2]),
                ),
                shell=True,
            )
