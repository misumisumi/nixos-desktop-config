"""start up hooks"""
from pathlib import Path
import subprocess
from libqtile import qtile, hook

from my_modules.global_config import GLOBAL
from my_modules.wallpaper import MONITOR0, MONITOR1, MONITOR2

from libqtile.log_utils import logger


def check_screen_saver():
    path = Path.home().joinpath(".cache", "betterlockscreen", "current", "lock_color.png")
    if not path.exists():
        subprocess.run("betterlockscreen -u {}".format(GLOBAL.screen_saver))


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
    if len(qtile.screens) == 1:
        subprocess.run(
            "feh --bg-fill {} --bg-fill {}".format(GLOBAL.wallpapers[0], GLOBAL.wallpapers[1]),
            shell=True,
        )
    if GLOBAL.vm:
        subprocess.run("feh --bg-fill {}".format(GLOBAL.wallpapers[0]), shell=True)
    else:
        # subprocess.run('feh --bg-fill {} --bg-fill {}'.format(str(GLOBAL.wallpapers[MONITOR0]), str(GLOBAL.wallpapers[MONITOR1])), shell=True)
        subprocess.run(
            "feh --bg-fill {} --bg-fill {}".format(
                str(GLOBAL.wallpapers[MONITOR0]),
                str(GLOBAL.wallpapers[MONITOR1]),
                str(GLOBAL.wallpapers[MONITOR2]),
            ),
            shell=True,
        )
    check_screen_saver()
    init_screen_and_group()


@hook.subscribe.startup_complete
def afterstart():
    subprocess.run("copyq &", shell=True)
    subprocess.run("kdeconnect-indicator &", shell=True)
