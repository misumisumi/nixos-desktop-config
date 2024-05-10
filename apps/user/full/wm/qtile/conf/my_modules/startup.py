"""start up hooks"""
import subprocess
from pathlib import Path

from libqtile import hook, qtile
from libqtile.log_utils import logger
from my_modules.global_config import GLOBAL
from my_modules.wallpaper import MONITOR0, MONITOR1, MONITOR2


# 擬似的に各スクリーンにグループが割り当てられるようにするための初期化
def init_screen_and_group():
    count = 0
    for i, _ in enumerate(qtile.screens):
        qtile.focus_screen(i)
        qtile.current_screen.set_group(qtile.groups[count])
        count += 7
    qtile.focus_screen(0)


@hook.subscribe.startup_once
def autostart():
    if GLOBAL.vm:
        subprocess.run("feh --bg-fill {}".format(GLOBAL.wallpapers[0]), shell=True)
    else:
        args = []
        for i, _ in enumerate(qtile.screens):
            args.append(f"--bg-fill {GLOBAL.wallpapers[i]}")
        subprocess.run(
            "feh " + " ".join(args),
            shell=True,
        )
    init_screen_and_group()


@hook.subscribe.startup_complete
def afterstart():
    subprocess.run("copyq &", shell=True)
    subprocess.run("kdeconnect-indicator &", shell=True)
