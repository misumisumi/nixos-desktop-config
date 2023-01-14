"""start up hooks"""
from pathlib import Path
import subprocess
from libqtile import qtile, hook

from my_modules.param import PARAM
from my_modules.set_wallpaper import MONITOR0, MONITOR1, MONITOR2

from libqtile.log_utils import logger


def check_screen_saver():
    path = Path.home().joinpath(
        ".cache", "betterlockscreen", "current", "lock_color.png"
    )
    if not path.exists():
        subprocess.run("betterlockscreen -u {}".format(PARAM.screen_saver))


# 擬似的に各スクリーンにグループが割り当てられるようにするための初期化
def init_screen_and_group():
    qtile.focus_screen(0)
    qtile.current_screen.set_group(qtile.groups[0])
    if not PARAM.laptop:
        qtile.focus_screen(1)
        qtile.current_screen.set_group(qtile.groups[7])
        qtile.focus_screen(2)
        qtile.current_screen.set_group(qtile.groups[14])
    qtile.focus_screen(0)


@hook.subscribe.startup_once
def autostart():
    if PARAM.laptop:
        subprocess.run(
            "feh --bg-fill {} --bg-fill {}".format(
                PARAM.wallpapers[0], PARAM.wallpapers[1]
            ),
            shell=True,
        )
    if PARAM.vm:
        subprocess.run("feh --bg-fill {}".format(PARAM.wallpapers[0]), shell=True)
    else:
        # subprocess.run('feh --bg-fill {} --bg-fill {}'.format(str(PARAM.wallpapers[MONITOR0]), str(PARAM.wallpapers[MONITOR1])), shell=True)
        subprocess.run(
            "feh --bg-fill {} --bg-fill {}".format(
                str(PARAM.wallpapers[MONITOR0]),
                str(PARAM.wallpapers[MONITOR1]),
                str(PARAM.wallpapers[MONITOR2]),
            ),
            shell=True,
        )
    check_screen_saver()
    init_screen_and_group()


@hook.subscribe.startup_complete
def afterstart():
    subprocess.run("copyq &", shell=True)
    subprocess.run("kdeconnect-indicator &", shell=True)
    subprocess.run("xmodmap -e 'keycode 255=space' -e 'keycode 65=Shift_L'", shell=True)
    subprocess.run("systemctl --user restart xcape.service", shell=True)
    # if PARAM.is_display_tablet:
    #     subprocess.run("xp-pen-driver-indicator", shell=True)
