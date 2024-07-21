"""widgets for qtile bar"""

from pathlib import Path

from libqtile import qtile, widget
from libqtile.log_utils import logger
from my_modules.global_config import GLOBAL
from xdg import IconTheme

_colorset1 = {
    "background": GLOBAL.c_normal["BGbase"],
    "foreground": GLOBAL.c_normal["cyan"],
}
_colorset2 = {
    "background": GLOBAL.c_normal["cyan"],
    "foreground": GLOBAL.c_normal["BGbase"],
}
_colorset3 = {
    "background": GLOBAL.c_normal["blue"],
    "foreground": GLOBAL.c_normal["BGbase"],
}
_colorset4 = {
    "background": GLOBAL.c_normal["BGbase"],
    "foreground": GLOBAL.c_normal["blue"],
}
_colorset5 = {
    "background": GLOBAL.c_normal["clear"],
    "foreground": GLOBAL.c_normal["BGbase"],
}
_colorset6 = {
    "background": GLOBAL.c_normal["BGbase"],
    "foreground": GLOBAL.c_normal["white"],
}
_colorset7 = {
    "background": GLOBAL.c_normal["clear"],
    "foreground": GLOBAL.c_normal["cyan"],
}
_colorset8 = {
    "background": GLOBAL.c_normal["BGbase"],
    "foreground": GLOBAL.c_normal["magenta"],
}
_colorset9 = {
    "background": GLOBAL.c_normal["clear"],
    "foreground": GLOBAL.c_normal["blue"],
}

_font_conf = {"font": GLOBAL.font, "fontsize": GLOBAL.font_size}

groupbox = widget.GroupBox(
    this_current_screen_border=GLOBAL.c_normal["cyan"],
    borderwidth=GLOBAL.border,
    active=GLOBAL.c_normal["white"],
    **_colorset3,
    **_font_conf,
)
cpu = widget.CPU(format="  {load_percent:0=4.1f}%", **_colorset2, **_font_conf)
memory = widget.Memory(
    format="  {MemUsed:0=4.1f}{mm}/{MemTotal: .1f}{mm}",
    measure_mem="G",
    measure_swap="G",
    **_colorset1,
    **_font_conf,
)
df = widget.DF(
    format="  {uf}{m}/{s}{m} ({r:.0f}%)",
    visible_on_warn=False,
    partition="/home",
    **_colorset2,
    **_font_conf,
)
chrod = widget.Chord(**_colorset8, **_font_conf)
wttr = widget.Wttr(format="%c%t/%p|", location={"Himeji": "Himeji"}, **_colorset2, **_font_conf)
clock = widget.Clock(format="%y-%m-%d %a %H:%M:%S", **_colorset2, **_font_conf)
net = widget.Net(
    format="{down:0=6.2f}{down_suffix:<2}↓↑{up:0=6.2f}{up_suffix:<2}",
    **_colorset2,
    **_font_conf,
)
volume = widget.Volume(
    fmt="  {}",
    get_volume_command="if [ -z $(pactl get-sink-mute $(pactl get-default-sink) | sed -e 's/Mute: no//g') ]; then echo \[$(pactl get-sink-volume $(pactl get-default-sink) | awk -F'/' '{print $2}' | sed -e 's/\s//g')\]; else echo M; fi",
    mute_command=["pactl set-source-mute @DEFAULT_SOURCE@ toggle"],
    volume_up_command=["pactl set-sink-volume @DEFAULT_SINK@ +5%"],
    volume_down_command=["pactl set-sink-volume @DEFAULT_SINK@ -5%"],
    **_colorset1,
    **_font_conf,
)
systray = widget.Systray(**_colorset3)
backlight = list(Path("/sys/class/backlight/").glob("*"))
if not len(backlight) == 0:
    backlight = widget.Backlight(fmt="  {}", backlight_name=backlight[0], **_colorset2, **_font_conf)
battery = widget.Battery(
    format="{char} {percent:2.0%}",
    charge_char="󰂄",
    discharge_char="󰂁",
    empty_char="󰁻",
    full_chal="󰂂",
    unknown_char="󰂃",
    **_colorset1,
    **_font_conf,
)


def _left_corner(background, foreground):
    return widget.TextBox(
        foreground=foreground,
        background=background,
        text=" ◖",
        font=GLOBAL.font,
        fontsize=GLOBAL.bar_font_size + 24,
        padding=-5,
    )


def _rignt_corner(background, foreground):
    return widget.TextBox(
        foreground=foreground,
        background=background,
        text="◗ ",
        font=GLOBAL.font,
        fontsize=GLOBAL.bar_font_size + 24,
        padding=-5,
    )


def _separator():
    return widget.Sep(linewidth=0, padding=2)


def make_bar(is_tray=False):
    top_widgets = [
        _left_corner(**_colorset4),
        groupbox,
        _rignt_corner(**_colorset4),
    ]
    if not (GLOBAL.under_fhd or GLOBAL.vm):
        top_widgets += [
            _separator(),
            _left_corner(**_colorset1),
            cpu,
            _rignt_corner(**_colorset1),
            memory,
            _rignt_corner(**_colorset2),
            df,
            _rignt_corner(**_colorset1),
            # widget.Spacer(),
        ]
    top_widgets += [
        _separator(),
        chrod,
        widget.Spacer(),
        _left_corner(**_colorset1),
        wttr,
        clock,
        _rignt_corner(**_colorset1),
        # widget.Spacer(),
    ]
    if GLOBAL.under_fhd:
        top_widgets += [
            widget.Spacer(),
        ]

    if not GLOBAL.under_fhd:
        top_widgets += [
            _separator(),
            _left_corner(**_colorset4),
            widget.TaskList(
                border=GLOBAL.c_normal["BGbase"],
                theme_mode="preferred",
                theme_path="Papirus-Dark",
                txt_floating="󱂬",
                txt_minimized="",
                txt_maximized="",
                icon_size=GLOBAL.icon_size,
                borderwidth=GLOBAL.border,
                **_colorset3,
                **_font_conf,
            ),
            _rignt_corner(**_colorset4),
            _separator(),
            _left_corner(**_colorset1),
            net,
            _rignt_corner(**_colorset1),
            volume,
            _rignt_corner(**_colorset2),
            widget.CurrentScreen(
                active_color=GLOBAL.c_normal["magenta"],
                inactive_color=GLOBAL.c_normal["BGbase"],
                inactive_text="N",
                **_colorset2,
                **_font_conf,
            ),
            _rignt_corner(**_colorset1),
        ]
    if is_tray:
        top_widgets += [
            _separator(),
            _left_corner(**_colorset4),
            systray,
            _rignt_corner(**_colorset4),
            _separator(),
        ]

    if GLOBAL.under_fhd or GLOBAL.vm:
        bottom_widgets = [
            _separator(),
            _left_corner(**_colorset7),
            cpu,
            _rignt_corner(**_colorset1),
            memory,
            _rignt_corner(**_colorset2),
            df,
            _rignt_corner(**_colorset7),
            _separator(),
            _left_corner(**_colorset9),
            widget.TaskList(
                border=GLOBAL.c_normal["BGbase"],
                theme_mode="preferred",
                theme_path="Papirus-Dark",
                txt_floating="󱂬",
                txt_minimized="",
                txt_maximized="",
                icon_size=GLOBAL.icon_size,
                borderwidth=GLOBAL.border,
                **_colorset3,
                **_font_conf,
            ),
            _rignt_corner(**_colorset9),
            _separator(),
            _left_corner(**_colorset7),
            net,
            _rignt_corner(**_colorset1),
            volume,
            _rignt_corner(**_colorset2),
        ]
        if GLOBAL.laptop:
            bottom_widgets += [
                backlight,
                _rignt_corner(**_colorset1),
                battery,
                _rignt_corner(**_colorset2),
            ]
        bottom_widgets += [
            widget.CurrentScreen(
                active_color=GLOBAL.c_normal["magenta"],
                inactive_color=GLOBAL.c_normal["BGbase"],
                inactive_text="N",
                **_colorset2,
                **_font_conf,
            ),
            _rignt_corner(**_colorset7),
        ]
    else:
        bottom_widgets = None

    return top_widgets, bottom_widgets


mybar_default = dict(
    padding=3,
    **_font_conf,
)
extension_defaults = mybar_default.copy()
