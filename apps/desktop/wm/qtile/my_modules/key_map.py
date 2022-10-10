"""short cut keys"""
from libqtile.config import Click, Drag, Key, KeyChord
from libqtile.lazy import lazy

from my_modules.param import PARAM
from my_modules.groups import GROUP_PER_SCREEN
from my_modules.my_functions import *

from libqtile.log_utils import logger


keys = [
    # Switch between windows
    Key([PARAM.mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([PARAM.mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([PARAM.mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([PARAM.mod], 'k', lazy.layout.up(), desc='Move focus up'),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([PARAM.mod, 'shift'], 'h',
        lazy.layout.shuffle_left(),
        # lazy.layout.move_left(),
        desc='Move window to the left'),
    Key([PARAM.mod, 'shift'], 'l',
        lazy.layout.shuffle_right(),
        # lazy.layout.move_right(),
        desc='Move window to the right'),
    Key([PARAM.mod, 'shift'], 'j', 
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move window down'),
    Key([PARAM.mod, 'shift'], 'k',
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move window up'),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([PARAM.mod, 'control'], 'h',
        focus_previous_group(),
        keep_pinp(),
        desc='focus prev group'),
    Key([PARAM.mod, 'control'], 'l',
        focus_next_group(),
        keep_pinp(),
        desc='focus next group'),

    Key([PARAM.mod, 'shift', 'control'], 'h', 
        window_to_previous_group(), keep_pinp(), desc='win to prev group'),
    Key([PARAM.mod, 'shift', 'control'], 'l',
        window_to_next_group(), keep_pinp(), desc='win to next group'),

    Key([PARAM.mod], 'n', focus_cycle_screen(),  desc='focus next screen'),
    Key([PARAM.mod], 'o', focus_cycle_screen(backward=True),  desc='focus next screen'),
    # Key([PARAM.mod, 'shift'], 'p', window_to_previous_screen(), keep_pinp()),
    Key([PARAM.mod, 'shift'], 'n', move_cycle_screen(), keep_pinp(), update_pinp_screen_idx()),
    Key([PARAM.mod, 'shift'], 'o', move_cycle_screen(backward=True), keep_pinp(), update_pinp_screen_idx()),

    Key([PARAM.mod, 'shift'], 'd', to_from_display_tablet(), keep_pinp(), update_pinp_screen_idx()),

    # Key([PARAM.mod, 'shift'], 't', move_display_tablet(), keep_pinp()),

    Key([PARAM.mod], 'space', lazy.window.toggle_maximize()),
    Key([PARAM.mod, 'shift'], 'space', lazy.window.toggle_minimize()),

    Key([PARAM.mod], 'f', lazy.window.toggle_fullscreen()),
    Key([PARAM.mod, 'shift'], 'f', lazy.window.toggle_floating()),

    # Attach Screen
    # Key([PARAM.mod], 'a', attach_screen()),
    KeyChord([PARAM.mod], 'a', [
        Key([], 'k', attach_screen('above')),
        Key([], 'j', attach_screen('below')),
        Key([], 'l', attach_screen('right-of')),
        Key([], 'h', attach_screen('left-of')),
        Key([], 'd', attach_screen('delete')),
        Key([], 'space', lazy.ungrab_chord()),
        ],
        mode='attach'
    ),

    # Change other layout
    Key([PARAM.mod], 'Tab', lazy.next_layout(),
        desc='Move window focus to other window'),

    Key([PARAM.mod], 's', lazy.layout.toggle_split(), desc='Launch terminal'),
    Key([PARAM.mod, 'shift'], 'Return', lazy.spawn(PARAM.terminal), desc='Launch terminal'),

    Key([PARAM.mod, 'shift'], 'c', lazy.window.kill(), desc='Kill focused window'),

    Key([PARAM.mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([PARAM.mod, 'control'], 'e', lazy.shutdown(), desc='Shutdown Qtile'),

    Key([PARAM.mod], 'p', lazy.spawn('rofi -combi-modi window,drun -show combi'), desc='show rofi'),
    Key([PARAM.mod, 'shift'], 'p', lazy.spawn('rofi -show run'), desc='run rofi script PARAM.mode'),
    Key([PARAM.mod, 'control'], 'p', lazy.spawn('rofi -show power-menu -modi power-menu:rofi-power-menu'), desc='show power-menu'),

    Key([PARAM.mod, 'control'], 'b', lazy.spawn('i3lock -n -i ./Pictures/archlinux_resize.png -t'), desc='lock PC'),

    Key([], 'Print', lazy.spawn('flameshot full -p {}'.format(str(PARAM.capture_path)))),
    Key([PARAM.mod], 'Print', capture_screen(is_clipboard=False)),
    Key([PARAM.mod, 'shift'], 'Print', capture_screen(is_clipboard=True)),
    Key([PARAM.mod], "period", float_cycle(forward=True)),
    Key([PARAM.mod], "comma", float_cycle(forward=True, focus=True)),

    Key([PARAM.mod], 'q', lazy.spawn('copyq toggle')),

    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%')),
    Key([], 'XF86AudioMute', lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle')),
    Key([], 'XF86AudioMicMute', lazy.spawn('pactl set-source-mute @DEFAULT_SOURCE@ toggle')),
    Key([], 'XF86AudioPause', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('playerctl next')),
    Key([], 'XF86AudioPrev', lazy.spawn('playerctl previous')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('light -A 5')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('light -U 5')),
    Key([], 'XF86KbdBrightnessUp', lazy.spawn('light -Ars {} 1'.format('sysfs/leds/asus::kbd_backlight'))),
    Key([], 'XF86KbdBrightnessDown', lazy.spawn('light -Urs {} 1'.format('sysfs/leds/asus::kbd_backlight'))),
    Key([], 'XF86Launch1', lazy.spawn('sh -c "/home/sumi/bin/swich_gpu_mode"')),
    Key([], 'XF86Launch4', lazy.spawn('asusctl profile -n')),

    # PinP operationes
    KeyChord([PARAM.mod], 'v', [
        Key([], 'k', move_pinp('up')),
        Key([], 'j', move_pinp('down')),
        Key([], 'l', move_pinp('right')),
        Key([], 'h', move_pinp('left')),
        Key([], 'space', lazy.ungrab_chord()),
        ],
        mode='pinp'
    )

]

for i in range(GROUP_PER_SCREEN):
    keys.extend([
        Key([PARAM.mod], str(i+1), focus_n_screen_group(i), keep_pinp,
            desc='Switch to group idx {}'.format(i+1)),

        Key([PARAM.mod, 'shift'], str(i+1), move_n_screen_group(i), keep_pinp,
            desc='Switch to & move focused window to group idx {}'.format(i+1)),
    ])

# Drag floating layouts.
mouse = [
    Drag([PARAM.mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([PARAM.mod, 'shift'], 'Button1', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
]
