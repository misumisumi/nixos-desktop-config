"""set wallpaper"""

import subprocess

from libqtile import hook, qtile
from libqtile.log_utils import logger

from my_modules.groups import group_and_rule
from my_modules.variables import GlobalConf

MONITORS = {}
cmd = "feh"
for i in range(GlobalConf.monitors_w_pentablet):
    MONITORS[f"MONITOR{i}"] = 0
    cmd += r" --bg-fill {}"


# 壁紙の割当(ラップトップはバッテリーの観点から固定)
@hook.subscribe.setgroup
def change_wallpaper():
    if not GlobalConf.laptop:
        global MONITORS
        group = qtile.current_screen.group
        gidx = qtile.groups.index(group)
        if qtile.current_screen in qtile.screens:
            idx = qtile.screens.index(qtile.current_screen)
            n_groups = len(group_and_rule)
            if gidx >= n_groups:
                gidx -= n_groups * idx
            MONITORS[f"MONITOR{idx}"] = gidx
            subprocess.run(
                cmd.format(
                    *[GlobalConf.wallpapers[MONITORS[f"MONITOR{i}"]] for i in range(GlobalConf.monitors_w_pentablet)]
                ),
                shell=True,
            )
