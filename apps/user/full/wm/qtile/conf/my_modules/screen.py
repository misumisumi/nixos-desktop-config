"""make screen"""

import subprocess

from libqtile import bar, hook
from libqtile.config import Screen
from libqtile.log_utils import logger

from my_modules.bar import make_bar
from my_modules.colorset import ColorSet
from my_modules.variables import BarConf, GlobalConf


def make_screens():
    cmd = [r"xrandr --listactivemonitors | tail -n+2 | awk -F' ' '{print $3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/'"]
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    monitors = list(map(lambda x: x.split("x"), monitors))

    screens = []
    bars = []
    for i, (x, y) in enumerate(monitors):
        under_fhd = int(x) <= 1920
        if i == 0:
            top_widgets, bottom_widgets = make_bar(under_fhd, is_tray=True)
        else:
            top_widgets, bottom_widgets = make_bar(under_fhd)
        if bottom_widgets is None:
            top_bar = bar.Bar(
                top_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                margin=BarConf.top_bar_margin,
            )
            bars.append(top_bar)
            screens.append(Screen(top=top_bar))
        else:
            top_bar = bar.Bar(
                top_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                margin=BarConf.top_bar_margin,
            )
            bottom_bar = bar.Bar(
                bottom_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                margin=BarConf.bottom_bar_margin,
            )
            bars.append(top_bar)
            bars.append(bottom_bar)
            screens.append(Screen(top=top_bar, bottom=bottom_bar))

        if GlobalConf.has_pentablet:
            top_widgets, _ = make_bar(pentablet=True)
            screens.append(Screen(top=None, bottom=None))

    @hook.subscribe.startup
    def _():
        for _bar in bars:
            _bar.window.window.set_property("QTILE_BAR", 1, "CARDINAL", 32)

    return screens
