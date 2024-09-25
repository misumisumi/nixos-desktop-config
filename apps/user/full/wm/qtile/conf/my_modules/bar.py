"""widgets for qtile bar"""

import copy
from dataclasses import asdict, dataclass
from pathlib import Path

# from libqtile import widget
from libqtile import bar
from libqtile.backend.base import core
from libqtile.log_utils import logger
from qtile_extras import widget

from my_modules.colorset import ColorSet
from my_modules.variables import FontConf, GlobalConf, WindowConf


@dataclass
class BarColorSet:
    colorset1 = {"background": ColorSet.background, "foreground": ColorSet.cyan}
    colorset2 = {"background": ColorSet.cyan, "foreground": ColorSet.background}
    colorset3 = {"background": ColorSet.blue, "foreground": ColorSet.background}
    colorset4 = {"background": ColorSet.background, "foreground": ColorSet.blue}
    colorset5 = {"background": ColorSet.background, "foreground": ColorSet.white}
    colorset6 = {"background": ColorSet.background, "foreground": ColorSet.white}
    colorset7 = {"background": ColorSet.background, "foreground": ColorSet.white}
    colorset8 = {"background": ColorSet.background, "foreground": ColorSet.magenta}
    colorset9 = {"background": ColorSet.background, "foreground": ColorSet.blue}


bcs = BarColorSet()
fc = asdict(FontConf)


right_corner = {"decorations": [widget.decorations.PowerLineDecoration(path="rounded_right")]}
left_corner = {"decorations": [widget.decorations.PowerLineDecoration(path="rounded_left")]}
only_one_group = {
    "background": ColorSet.transparent,
    "decorations": [
        widget.decorations.RectDecoration(
            colour=ColorSet.background,
            radius=14,
            filled=True,
            padding_y=0,
            padding_x=0,
            group=True,
            use_widget_background=False,
        )
    ],
}


# widgets config
def spacer(length=bar.STRETCH):
    return [widget.Spacer(length=length, background=ColorSet.transparent, padding=0)]


def groupbox():
    return [
        widget.TextBox(padding=5, **only_one_group),
        widget.GroupBox(
            this_current_screen_border=ColorSet.cyan,
            this_screen_border=ColorSet.blue,
            other_current_screen_border=ColorSet.cyan,
            other_screen_border=ColorSet.blue,
            use_mouse_wheel=False,
            highlight_method="line",
            active=ColorSet.white,
            margin_x=1,
            margin_y=3,
            **fc,
            **only_one_group,
        ),
        widget.TextBox(padding=5, **only_one_group),
    ]


def sysinfo():
    return [
        widget.TextBox(padding=0, background=ColorSet.transparent, **right_corner),
        widget.Net(
            format="{down:0=6.2f}{down_suffix:<2}↓↑{up:0=6.2f}{up_suffix:<2}",
            **fc,
            **left_corner,
        ),
        widget.CPU(
            format=" {load_percent:0=4.1f}%",
            **fc,
            foreground=ColorSet.background,
            background=ColorSet.blue,
            **left_corner,
        ),
        widget.Memory(
            format=" {MemUsed:0=4.1f}{mm}/{MemTotal:.1f}{mm}",
            measure_mem="G",
            measure_swap="G",
            **fc,
            **left_corner,
        ),
        widget.DF(
            format=" {uf}{m}/{s}{m}({r:.0f}%)",
            visible_on_warn=False,
            partition="/home",
            foreground=ColorSet.background,
            background=ColorSet.blue,
            **fc,
            **left_corner,
        ),
    ]


def sysctrl(is_tray=False):
    base = [
        widget.TextBox(padding=0, background=ColorSet.transparent, **right_corner),
        widget.Volume(
            fmt=" {}",
            get_volume_command="if [ -z $(pactl get-sink-mute $(pactl get-default-sink) | sed -e 's/Mute: no//g') ]; then echo \[$(pactl get-sink-volume $(pactl get-default-sink) | awk -F'/' '{print $2}' | sed -e 's/\s//g')\]; else echo M; fi",
            mute_command=["pactl set-source-mute @DEFAULT_SOURCE@ toggle"],
            volume_up_command=["pactl set-sink-volume @DEFAULT_SINK@ +5%"],
            volume_down_command=["pactl set-sink-volume @DEFAULT_SINK@ -5%"],
            **fc,
            **left_corner,
        ),
    ]
    if GlobalConf.laptop:
        base += [
            widget.UPowerWidget(),
        ]
        if not len(list(Path("/sys/class/backlight/").glob("*"))) == 0:
            base += [
                widget.Backlight(
                    fmt="  {}",
                    backlight_name=backlight[0],
                    foreground=ColorSet.background,
                    background=ColorSet.blue,
                    **fc,
                )
            ]
    if is_tray:
        base += [
            widget.StatusNotifier(
                icon_theme="Papirus-Dark",
                **left_corner,
            ),
        ]

    return base


def lifeinfo():
    return [
        widget.TextBox(padding=0, background=ColorSet.transparent, **right_corner),
        widget.Wttr(format="%c%t/%p", location={"Yonezawa": "Yonezawa"}, **fc, **left_corner),
        widget.Clock(
            format="%y-%m-%d(%a) %H:%M:%S",
            foreground=ColorSet.background,
            background=ColorSet.blue,
            **fc,
            **left_corner,
        ),
    ]


def systray():
    return [
        widget.Sep(linewidth=0, padding=10, background=ColorSet.transparent),
        widget.TextBox(padding=0, **only_one_group),
        widget.StatusNotifier(
            icon_theme="Papirus-Dark",
            **only_one_group,
        ),
        widget.TextBox(padding=0, **only_one_group),
    ]


backlight = list(Path("/sys/class/backlight/").glob("*"))
if not len(backlight) == 0:
    backlight = widget.Backlight(
        fmt="  {}",
        backlight_name=backlight[0],
        # **bcs.colorset2,
        **fc,
    )

battery = widget.Battery(
    format="{char} {percent:2.0%}",
    charge_char="󰂄",
    discharge_char="󰂁",
    empty_char="󰁻",
    full_chal="󰂂",
    unknown_char="󰂃",
    **fc,
)


def chord():
    return [
        widget.Chord(**fc, **only_one_group),
    ]


def tasklist():
    def parse_text(text):
        max_char = 10
        if len(text) > max_char:
            return text[: max_char - 1] + "…"
        else:
            return text

    return [
        widget.TextBox(padding=0, **only_one_group),
        widget.TaskList(
            border=ColorSet.blue,
            markup_focused="<span foreground=" + f'"{ColorSet.background}"' + ">{}</span>",
            theme_mode="fallback",
            txt_floating="󱂬 ",
            txt_minimized=" ",
            txt_maximized=" ",
            highlight_method="block",
            unfocused_border="block",
            parse_text=parse_text,
            borderwidth=WindowConf.border,
            padding=3,
            menu_font=FontConf.font,
            menu_fontsize=FontConf.fontsize,
            **only_one_group,
        ),
        widget.TextBox(padding=0, **only_one_group),
    ]


def separator():
    return [widget.Sep(linewidth=0, padding=2, background=ColorSet.transparent)]


def make_bar(is_tray=False):
    top_widgets = []
    top_widgets += groupbox()
    # if not (GlobalConf.under_fhd or GlobalConf.vm):
    #     top_widgets += [
    #         _separator(),
    #         # _left_corner(**bcs.colorset1),
    #         cpu,
    #         # _rignt_corner(**bcs.colorset1),
    #         memory,
    #         # _rignt_corner(**bcs.colorset2),
    #         df,
    #         # _rignt_corner(**bcs.colorset1),
    #         # widget.Spacer(),
    #     ]
    top_widgets += spacer(length=50)
    if not GlobalConf.under_fhd:
        top_widgets += tasklist()
        top_widgets += spacer(length=20)
    top_widgets += lifeinfo()
    top_widgets += spacer()

    top_widgets += spacer(length=5)
    top_widgets += chord()
    top_widgets += spacer(length=10)

    top_widgets += sysinfo()
    top_widgets += spacer(length=20)
    top_widgets += sysctrl(is_tray)
    # if is_tray:
    #     top_widgets += separator()
    #     top_widgets += systray()
    # else:
    #     top_widgets += spacer()

    if GlobalConf.under_fhd or GlobalConf.vm:
        bottom_widgets = sysinfo()
        bottom_widgets += separator()
        bottom_widgets += tasklist()
        if GlobalConf.laptop:
            bottom_widgets += [
                backlight,
                # _rignt_corner(**bcs.colorset1),
                battery,
                # _rignt_corner(**bcs.colorset2),
            ]
        bottom_widgets += [
            widget.CurrentScreen(
                active_color=ColorSet.magenta,
                inactive_color=ColorSet.background,
                inactive_text="N",
                **bcs.colorset2,
                **fc,
            ),
            # _rignt_corner(**bcs.colorset7),
        ]
    else:
        bottom_widgets = None

    return top_widgets, bottom_widgets


def set_bar_default():
    default_background = {
        "colour": ColorSet.transparent,
        "radius": 5,
        "filled": True,
        "padding_y": 0,
        "padding_x": 0,
        "group": True,
        "use_widget_background": True,
    }
    widget_defaults = dict(
        font=FontConf.font,
        background=ColorSet.background,
        foreground=ColorSet.foreground,
        fontsize=FontConf.fontsize,
        padding_x=3,
        padding_y=2,
        # decorations=[widget.decorations.RectDecoration(**default_background)],
    )

    extension_defaults = widget_defaults.copy()

    return default_background, widget_defaults, extension_defaults
