"""make screen"""

import subprocess

from libqtile import hook
from libqtile.config import Screen
from libqtile.log_utils import logger

from my_modules.bar import make_bar
from my_modules.colorset import ColorSet
from my_modules.variables import BarConf, GlobalConf


def make_screens():
    cmd = [r"xrandr --listactivemonitors | tail -n+2 | awk -F' ' '{print $3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/'"]
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    monitors = list(map(lambda x: x.split("x"), monitors))
    if GlobalConf.has_pentablet:
        monitors = monitors[:-1]

    screens = []
    bars = []
    for i, (x, y) in enumerate(monitors):
        under_fhd = int(x) <= 1920
        if i == 0:
            top_bar, bottom_bar = make_bar(under_fhd, is_tray=True)
        else:
            top_bar, bottom_bar = make_bar(under_fhd)
        if bottom_bar is None:
            bars.append(top_bar)
            screens.append(Screen(top=top_bar))
        else:
            bars.append(top_bar)
            bars.append(bottom_bar)
            screens.append(Screen(top=top_bar, bottom=bottom_bar))

    if GlobalConf.has_pentablet:
        top_bar, _ = make_bar(pentablet=True)
        bars.append(top_bar)

        screens.append(Screen(top=top_bar, bottom=None))

    @hook.subscribe.startup
    def _():
        for _bar in bars:
            _bar.window.window.set_property("QTILE_BAR", 1, "CARDINAL", 32)

    return screens
