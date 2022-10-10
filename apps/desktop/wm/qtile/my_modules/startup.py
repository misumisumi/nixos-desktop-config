"""start up hooks"""
import subprocess
from libqtile import qtile, hook

from my_modules.param import PARAM
from my_modules.set_wallpaper import MONITOR0, MONITOR1, MONITOR2

from libqtile.log_utils import logger


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
        subprocess.run('feh --bg-fill {} --bg-fill {}'.format(PARAM.home.joinpath('Pictures', 'wallpapers', 'main01.jpg'),
                                                              PARAM.home.joinpath('Pictures', 'wallpapers', 'main02.jpg')), shell=True)
    else:
        # subprocess.run('feh --bg-fill {} --bg-fill {}'.format(str(PARAM.wallpapers[MONITOR0]), str(PARAM.wallpapers[MONITOR1])), shell=True)
        subprocess.run('feh --bg-fill {} --bg-fill {}'.format(str(PARAM.wallpapers[MONITOR0]), str(PARAM.wallpapers[MONITOR1]), str(PARAM.wallpapers[MONITOR2])), shell=True)
    init_screen_and_group()


@hook.subscribe.startup_complete
def afterstart():
    subprocess.run('copyq &', shell=True)
    if PARAM.is_display_tablet:
        subprocess.run('/usr/lib/pentablet/pentablet /mini &', shell=True)

