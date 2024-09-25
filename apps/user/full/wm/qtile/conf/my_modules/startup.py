"""start up hooks"""

import subprocess

from libqtile import hook, qtile
from libqtile.log_utils import logger

from my_modules.groups import group_and_rule
from my_modules.variables import GlobalConf


# 擬似的に各スクリーンにグループが割り当てられるようにするための初期化
def init_screen_and_group():
    count = 0
    for i, _ in enumerate(qtile.screens):
        qtile.focus_screen(i)
        qtile.current_screen.set_group(qtile.groups[count])
        count += len(group_and_rule.keys())
    qtile.focus_screen(0)


@hook.subscribe.startup_once
def autostart():
    args = []
    for i, _ in enumerate(qtile.screens):
        args.append(f"--bg-fill {GlobalConf.wallpapers[i]}")
    subprocess.run(
        "feh " + " ".join(args),
        shell=True,
    )
    init_screen_and_group()


@hook.subscribe.startup_complete
def afterstart():
    subprocess.run("systemctl --user restart blueman-applet.service", shell=True)
