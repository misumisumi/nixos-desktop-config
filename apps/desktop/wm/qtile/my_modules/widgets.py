"""widgets for qtile bar"""
from pathlib import Path
from libqtile import bar, widget
from xdg import IconTheme

from my_modules.param import PARAM

from libqtile.log_utils import logger

logger.warning("-"*50)
logger.warning(IconTheme.getIconPath("flameshot", 32))
logger.warning("-"*50)


_colorset1 = {'background': PARAM.c_normal['BGbase'], 'foreground': PARAM.c_normal['cyan']}
_colorset2 = {'background': PARAM.c_normal['cyan'], 'foreground': PARAM.c_normal['BGbase']}
_colorset3 = {'background': PARAM.c_normal['blue'], 'foreground': PARAM.c_normal['BGbase']}
_colorset4 = {'background': PARAM.c_normal['BGbase'], 'foreground': PARAM.c_normal['blue']}
_colorset5 = {'background': PARAM.c_normal['clear'], 'foreground': PARAM.c_normal['BGbase']}
_colorset6 = {'background': PARAM.c_normal['BGbase'], 'foreground': PARAM.c_normal['white']}
_colorset7 = {'background': PARAM.c_normal['clear'], 'foreground': PARAM.c_normal['cyan']}
_colorset8 = {'background': PARAM.c_normal['BGbase'], 'foreground': PARAM.c_normal['magenta']}


def _left_corner(background, foreground):
    return widget.TextBox(
        foreground = foreground,
        background = background,
        text = " ◖",
        font=PARAM.font,
        fontsize = PARAM.bar_font_size+24,
        padding=-5
    )

def _rignt_corner(background, foreground):
    return widget.TextBox(
        foreground = foreground,
        background = background,
        text = "◗ ",
        font=PARAM.font,
        fontsize = PARAM.bar_font_size+24,
        padding=-5
    )

def _separator():
    return widget.Sep(
        linewidth = 0,
        padding = 2
    )


def make_widgets(is_tray=False):
    top_widgets = [
        _left_corner(**_colorset4),
        widget.GroupBox(this_current_screen_border=PARAM.c_normal['cyan'], borderwidth=PARAM.border, **_colorset3,
                        font='Hack Nerd Font', fontsize=PARAM.font_size+2,
                        active=PARAM.c_normal['white']),
        _rignt_corner(**_colorset4),
        ]
    if not (PARAM.laptop or PARAM.vm):
        top_widgets += [
            _separator(),
            _left_corner(**_colorset1),
            widget.CPU(format=' {load_percent:0=4.1f}%', **_colorset2),
            _rignt_corner(**_colorset1),
            widget.Memory(format=' {MemUsed:0=4.1f}{mm}/{MemTotal: .1f}{mm}',
                          measure_mem='G', measure_swap='G', **_colorset1),
            _rignt_corner(**_colorset2),
            widget.DF(format = " {uf}{m}/{s}{m} ({r:.0f}%)", visible_on_warn=False,
                      partition='/home', **_colorset2),
            _rignt_corner(**_colorset1),
        ]
    top_widgets += [
        _separator(),
        widget.Chord(**_colorset8),
        widget.Spacer(),
        _left_corner(**_colorset1),
        widget.Wttr(format='%c%t/%p|', location={'Himeji':'Himeji'}, **_colorset2),
        widget.Clock(format='%y-%m-%d %a %H:%M:%S', **_colorset2),
        _rignt_corner(**_colorset1),
        ]

    top_widgets += [
        _separator(),
        _left_corner(**_colorset4),
        widget.TaskList(border=PARAM.c_normal['BGbase'], icon_size=PARAM.font_size, borderwidth=PARAM.border, max_title_width=120, **_colorset3),
        _rignt_corner(**_colorset4),
        _separator()
    ]

    if not (PARAM.laptop or PARAM.vm):
        top_widgets += [
            _left_corner(**_colorset1),
            widget.Net(format='{down} ↓↑ {up}', **_colorset2),
            _rignt_corner(**_colorset1),
            # widget.PulseVolume(fmt=' {}', limit_max_volume=True, volume_app='pavucontrol',
            #                    update_interval=0.1, **_colorset1),
            widget.Volume(fmt=' {}',   
                          get_volume_command = ["sh", "-c", "if [ -z \"$(pactl get-sink-mute $(pactl get-default-sink) | sed -e 's/Mute: no//g')\" ]; then echo \[$(pactl get-sink-volume $(pactl get-default-sink) | awk -F'/' '{print $2}' | sed -e 's/\s//g')\]; else echo M; fi"],
                          mute_command = ["pactl set-source-mute @DEFAULT_SOURCE@ toggle"],
                          volume_up_command = ["pactl set-sink-volume @DEFAULT_SINK@ +5%"],
                          volume_down_command = ["pactl set-sink-volume @DEFAULT_SINK@ -5%"],
                          **_colorset1),
            _rignt_corner(**_colorset2),
            widget.CurrentScreen(active_color=PARAM.c_normal['magenta'],
                                 inactive_color=PARAM.c_normal['BGbase'],
                                 inactive_text='N', **_colorset2),
            _rignt_corner(**_colorset1)
            ]
    if is_tray:
        top_widgets += [
            _separator(),
            _left_corner(**_colorset4),
            widget.Systray(**_colorset3),
            # widget.StatusNotifier(**_colorset3),
            _rignt_corner(**_colorset4),
            _separator(),
        ]

    if PARAM.laptop or PARAM.vm:
        backlight = list(Path('/sys/class/backlight/').glob('*'))
        bottom_widgets = [
            _separator(),
            _left_corner(**_colorset7),
            widget.CPU(format=' {load_percent:0=4.1f}%', **_colorset2),
            _rignt_corner(**_colorset1),
            widget.Memory(format=' {MemUsed:0=4.1f}{mm}/{MemTotal: .1f}{mm}',
                          measure_mem='G', measure_swap='G', **_colorset1),
            _rignt_corner(**_colorset2),
            widget.DF(format = " {uf}{m}/{s}{m} ({r:.0f}%)", visible_on_warn=False,
                      partition='/home', **_colorset2),
            _rignt_corner(**_colorset7),
            widget.Spacer(),

            _left_corner(**_colorset7),
            widget.Net(format='{down} ↓↑ {up}', **_colorset2),
            _rignt_corner(**_colorset1),
            widget.Volume(fmt=' {}',   
                          get_volume_command = ["sh", "-c", "if [ -z \"$(pactl get-sink-mute $(pactl get-default-sink) | sed -e 's/Mute: no//g')\" ]; then echo \[$(pactl get-sink-volume $(pactl get-default-sink) | awk -F'/' '{print $2}' | sed -e 's/\s//g')\]; else echo M; fi"],
                          mute_command = ["pactl set-source-mute @DEFAULT_SOURCE@ toggle"],
                          volume_up_command = ["pactl set-sink-volume @DEFAULT_SINK@ +5%"],
                          volume_down_command = ["pactl set-sink-volume @DEFAULT_SINK@ -5%"],
                          **_colorset1),
            _rignt_corner(**_colorset2)
        ]
        if PARAM.laptop:
            bottom_widgets += [
                widget.Backlight(fmt=' {}', backlight_name=backlight[0], **_colorset2),
                _rignt_corner(**_colorset1),
                widget.Battery(format='{char} {percent:2.0%}', charge_char='', discharge_char='',
                               empty_char='', full_chal='', unknown_char='', **_colorset1),
                _rignt_corner(**_colorset2),
            ]
        bottom_widgets += [
            widget.CurrentScreen(active_color=PARAM.c_normal['magenta'],
                                 inactive_color=PARAM.c_normal['BGbase'],
                                 inactive_text='N', **_colorset2),
            _rignt_corner(**_colorset7)
        ]
    else:
        bottom_widgets = None

    return top_widgets, bottom_widgets


widget_defaults =  dict(
                    font=PARAM.font,
                    fontsize=PARAM.font_size,
                    padding=3
                )
extension_defaults = widget_defaults.copy()
