"""make screen"""

from libqtile import bar, hook
from libqtile.config import Screen
from libqtile.log_utils import logger

from my_modules.bar import make_bar
from my_modules.colorset import ColorSet
from my_modules.variables import BarConf, GlobalConf


def make_screens(num_screen):
    screens = []
    bars = []
    for i in range(num_screen):
        if i == 0:
            top_widgets, bottom_widgets = make_bar(is_tray=True)
        else:
            top_widgets, bottom_widgets = make_bar()
        if bottom_widgets is None:
            top_bar = bar.Bar(
                top_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                border_color=ColorSet.cyan,
                margin=BarConf.top_bar_margin,
            )
            bars.append(top_bar)
            screens.append(Screen(top=top_bar))
        elif GlobalConf.is_display_tablet and i > num_screen:
            screens.append(Screen(top=None))
        else:
            top_bar = bar.Bar(
                top_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                border_color=ColorSet.cyan,
                margin=BarConf.top_bar_margin,
            )
            bottom_bar = bar.Bar(
                bottom_widgets,
                BarConf.size,
                background=ColorSet.transparent,
                border_color=ColorSet.cyan,
                margin=BarConf.bottom_bar_margin,
            )
            bars.append(top_bar)
            bars.append(bottom_bar)
            screens.append(Screen(top=top_bar, bottom=bottom_bar))

    @hook.subscribe.startup
    def _():
        for _bar in bars:
            _bar.window.window.set_property("QTILE_BAR", 1, "CARDINAL", 32)

    return screens


screens = make_screens(GlobalConf.num_screen)
