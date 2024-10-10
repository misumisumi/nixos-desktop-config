"""make screen"""

from libqtile import hook, qtile
from libqtile.config import Screen
from libqtile.log_utils import logger

from my_modules.bar import make_bar
from my_modules.utils import get_phy_monitors
from my_modules.variables import GlobalConf


def make_screens(manually: bool = False):
    monitors = get_phy_monitors(GlobalConf.has_pentablet)

    screens = []
    bars = []
    for i, (_, (x, y)) in enumerate(monitors):
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

    return screens


@hook.subscribe.startup
def set_bar_property():
    for screen in qtile.screens:
        for pos in ["top", "bottom"]:
            bar = getattr(screen, pos)
            if bar:
                bar.window.window.set_property("QTILE_BAR", 1, "CARDINAL", 32)
