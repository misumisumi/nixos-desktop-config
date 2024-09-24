"""make screen"""
from libqtile import bar
from libqtile.config import Screen

from my_modules.global_config import GLOBAL
from my_modules.bar import make_bar

from libqtile.log_utils import logger


def make_screens(num_screen):
    screens = []
    for i in range(num_screen):
        if i == 0:
            top_widgets, bottom_widgets = make_bar(is_tray=True)
        else:
            top_widgets, bottom_widgets = make_bar()
        if bottom_widgets is None:
            screens.append(
                Screen(
                    top=bar.Bar(
                        top_widgets,
                        GLOBAL.bar_font_size,
                        background=GLOBAL.c_normal["BGbase"],
                        border_color=GLOBAL.c_normal["cyan"],
                    ),
                )
            )
        elif GLOBAL.is_display_tablet and i > num_screen:
            screens.append(Screen(top=None))
        else:
            screens.append(
                Screen(
                    top=bar.Bar(
                        top_widgets,
                        GLOBAL.bar_font_size,
                        background=GLOBAL.c_normal["BGbase"],
                        border_color=GLOBAL.c_normal["cyan"],
                    ),
                    bottom=bar.Bar(
                        bottom_widgets,
                        GLOBAL.bar_font_size,
                        background=GLOBAL.c_normal["clear"],
                        border_color=GLOBAL.c_normal["cyan"],
                    ),
                )
            )

    return screens


screens = make_screens(GLOBAL.num_screen)