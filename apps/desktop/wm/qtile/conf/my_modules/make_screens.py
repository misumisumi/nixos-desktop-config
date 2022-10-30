"""make screen"""
from libqtile import bar
from libqtile.config import Screen

from my_modules.param import PARAM
from my_modules.widgets import make_widgets

from libqtile.log_utils import logger


def make_screens(num_screen):
    screens = []
    for i in range(num_screen):
        if i == 0:
            top_widgets, bottom_widgets = make_widgets(is_tray=True)
        else:
            top_widgets, bottom_widgets = make_widgets()
        if bottom_widgets is None:
            screens.append(
                Screen(
                    top=bar.Bar(
                        top_widgets,
                        PARAM.bar_font_size,
                        background=PARAM.c_normal['BGbase'],
                        border_color=PARAM.c_normal['cyan']
                    ),
                    )
                )
        elif PARAM.is_display_tablet and i>num_screen:
            screens.append(
                Screen(
                    top=None
                    )
                )
        else:
            screens.append(
                Screen(
                    top=bar.Bar(
                        top_widgets,
                        PARAM.bar_font_size,
                        background=PARAM.c_normal['BGbase'],
                        border_color=PARAM.c_normal['cyan']
                    ),
                    bottom = bar.Bar(
                        bottom_widgets,
                        PARAM.bar_font_size,
                        background=PARAM.c_normal['clear'],
                        border_color=PARAM.c_normal['cyan'],
                    )
                    )
                )

    return screens


screens = make_screens(PARAM.num_screen)

