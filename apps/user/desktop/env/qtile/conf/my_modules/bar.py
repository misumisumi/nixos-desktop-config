"""widgets for qtile bar"""

from dataclasses import asdict
from pathlib import Path

# from libqtile import widget
from libqtile import bar
from libqtile.log_utils import logger
from qtile_extras import widget

from my_modules.colorset import ColorSet
from my_modules.variables import BarConf, FontConf, GlobalConf, IconConf, WindowConf

fc = asdict(FontConf)
ic = asdict(IconConf)


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


def separator():
    return [widget.Sep(linewidth=0, padding=2, background=ColorSet.transparent)]


def groupbox():
    return [
        widget.TextBox(padding=2, **only_one_group),
        widget.GroupBox(
            this_current_screen_border=ColorSet.accent,
            this_screen_border=ColorSet.foreground,
            other_current_screen_border=ColorSet.accent,
            other_screen_border=ColorSet.foreground,
            use_mouse_wheel=False,
            highlight_method="line",
            active=ColorSet.white,
            margin_x=3,
            margin_y=3,
            **fc,
            **only_one_group,
        ),
        widget.TextBox(padding=2, **only_one_group),
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
            background=ColorSet.accent,
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
            background=ColorSet.accent,
            **fc,
            **left_corner,
        ),
    ]


def sysctrl(is_tray=False):
    base = [
        widget.TextBox(padding=0, background=ColorSet.transparent, **right_corner),
    ]
    if GlobalConf.laptop:
        backlight = list(Path("/sys/class/backlight/").glob("*"))
        if not len(backlight) == 0:
            base += [
                widget.Backlight(
                    fmt=" {}",
                    backlight_name=backlight[0],
                    **fc,
                    **left_corner,
                ),
            ]
        vol_colors = {
            "foreground": ColorSet.background,
            "background": ColorSet.accent,
        }
    else:
        vol_colors = {}
    base += [
        widget.Volume(
            fmt=" {}",
            get_volume_command="if [ -z $(pactl get-sink-mute $(pactl get-default-sink) | sed -e 's/Mute: no//g') ]; then echo \[$(pactl get-sink-volume $(pactl get-default-sink) | awk -F'/' '{print $2}' | sed -e 's/\s//g')\]; else echo M; fi",
            mute_command=["pactl set-source-mute @DEFAULT_SOURCE@ toggle"],
            volume_up_command=["pactl set-sink-volume @DEFAULT_SINK@ +5%"],
            volume_down_command=["pactl set-sink-volume @DEFAULT_SINK@ -5%"],
            **vol_colors,
            **fc,
            **left_corner,
        ),
    ]
    if GlobalConf.laptop:
        base += [
            widget.UPowerWidget(
                **left_corner,
            ),
        ]
    base += [
        widget.CurrentLayoutIcon(
            foreground=ColorSet.background,
            background=ColorSet.black,
            padding=0,
            scale=0.6,
            **fc,
            **left_corner,
        ),
    ]
    if is_tray:
        base += [
            widget.StatusNotifier(**ic, **left_corner),
        ]

    return base


def lifeinfo():
    return [
        widget.TextBox(padding=0, background=ColorSet.transparent, **right_corner),
        widget.Wttr(format="%c%t/%p", **fc, **left_corner),
        widget.Clock(
            format="%y-%m-%d(%a) %H:%M:%S",
            foreground=ColorSet.background,
            background=ColorSet.accent,
            **fc,
            **left_corner,
        ),
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
            border=ColorSet.accent,
            markup_focused="<span foreground=" + f'"{ColorSet.background}"' + ">{}</span>",
            theme_mode="fallback",
            txt_floating="󱂬 ",
            txt_minimized=" ",
            txt_maximized=" ",
            highlight_method="block",
            parse_text=parse_text,
            borderwidth=WindowConf.border,
            padding=3,
            menu_font=FontConf.font,
            menu_fontsize=FontConf.fontsize,
            **only_one_group,
        ),
        widget.TextBox(padding=0, **only_one_group),
    ]


def chord():
    return [widget.Chord(**fc, **only_one_group)]


def make_bar(under_fhd: bool = False, is_tray: bool = False, pentablet: bool = False) -> tuple:
    top_widgets = []
    if pentablet:
        top_widgets += lifeinfo()
        top_widgets += spacer()
        top_widgets += tasklist()
        top_widgets += spacer()
    else:
        top_widgets += groupbox()
        top_widgets += spacer(length=10)
        top_widgets += chord()
        if under_fhd:
            top_widgets += spacer()
        else:
            top_widgets += spacer(length=10)
            top_widgets += tasklist()
            top_widgets += spacer(length=20)
        top_widgets += lifeinfo()
        top_widgets += spacer()

        if not under_fhd:
            top_widgets += sysinfo()
        top_widgets += spacer(length=10)
        top_widgets += sysctrl(is_tray)

    top_bar = bar.Bar(
        top_widgets,
        BarConf.size,
        background=ColorSet.transparent,
        margin=BarConf.top_bar_margin,
    )

    if under_fhd and not pentablet:
        bottom_widgets = tasklist()
        bottom_widgets += spacer(length=20)
        bottom_widgets += sysinfo()
        bottom_bar = bar.Bar(
            bottom_widgets,
            BarConf.size,
            background=ColorSet.transparent,
            margin=BarConf.bottom_bar_margin,
        )
    else:
        bottom_bar = None

    return top_bar, bottom_bar
