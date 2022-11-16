"""short cut keys"""
from libqtile.config import Click, Drag, Key, KeyChord
from libqtile.lazy import lazy

from my_modules.param import PARAM
from my_modules.groups import GROUP_PER_SCREEN
from my_modules.my_functions import *

from libqtile.log_utils import logger


keys = [
    Key([PARAM.mod, 'shift'], 'Return', lazy.spawn(PARAM.terminal), desc='Launch terminal'),
    # Operate window in workspace
    Key([PARAM.mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([PARAM.mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([PARAM.mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([PARAM.mod], 'k', lazy.layout.up(), desc='Move focus up'),
    Key([PARAM.mod, 'shift'], 'h', lazy.layout.shuffle_left(), desc='Move window to the left'),
    Key([PARAM.mod, 'shift'], 'l', lazy.layout.shuffle_right(), desc='Move window to the right'),
    Key([PARAM.mod, 'shift'], 'j', lazy.layout.shuffle_down(), lazy.layout.section_down(), desc='Move window down'),
    Key([PARAM.mod, 'shift'], 'k', lazy.layout.shuffle_up(), lazy.layout.section_up(), desc='Move window up'),
    Key([PARAM.mod, 'control'], 'c', lazy.window.kill(), desc='Kill focused window'),
    # Operate floating window
    Key([PARAM.mod], "period", float_cycle(forward=True)),
    Key([PARAM.mod], "comma", float_cycle(forward=True, focus=True)),
    # Operate window between workspaces
    Key([PARAM.mod, 'control'], 'h', focus_previous_group(), keep_pinp(), desc='focus prev group'),
    Key([PARAM.mod, 'control'], 'l', focus_next_group(), keep_pinp(), desc='focus next group'),
    Key([PARAM.mod, 'control'], 'j', window_to_previous_group(), keep_pinp(), desc='window to prev group'),
    Key([PARAM.mod, 'control'], 'k', window_to_next_group(), keep_pinp(), desc='window to next group'),
    # Operate screen
    Key([PARAM.mod], 'n', focus_cycle_screen(),  desc='focus next screen'),
    Key([PARAM.mod], 'p', focus_cycle_screen(backward=True),  desc='focus prev screen'),
    Key([PARAM.mod, 'shift'], 'n', move_cycle_screen(), keep_pinp(), update_pinp_screen_idx()),
    Key([PARAM.mod, 'shift'], 'p', move_cycle_screen(backward=True), keep_pinp(), update_pinp_screen_idx()),
    Key([PARAM.mod, 'shift'], 'd', to_from_display_tablet(), keep_pinp(), update_pinp_screen_idx()),
    # Toggle Float and FullScreen
    Key([PARAM.mod], 'space', lazy.window.toggle_maximize()),
    Key([PARAM.mod, 'shift'], 'space', lazy.window.toggle_minimize()),
    Key([PARAM.mod], 'f', lazy.window.toggle_fullscreen()),
    Key([PARAM.mod, 'shift'], 'f', lazy.window.toggle_floating()),
    # Exit and Reload
    Key([PARAM.mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([PARAM.mod, 'control'], 'e', lazy.shutdown(), desc='Shutdown Qtile'),
    # Launch rofi
    Key([PARAM.mod], 'm', lazy.spawn('rofi -combi-modi window,drun -show combi'), desc='show rofi'),
    Key([PARAM.mod, 'shift'], 'm', lazy.spawn('rofi -show run'), desc='run rofi as shell mode'),
    Key([PARAM.mod, 'control'], 'm', lazy.spawn('rofi -show mower-menu -modi mower-menu:rofi-mower-menu'), desc='show mower-menu'),
    # Lock screen
    Key([PARAM.mod, 'control'], 'b', lazy.spawn('i3lock -n -t -i {}'.format(PARAM.screen_saver)), desc='lock PC'),
    # Screenshot
    Key([], 'Print', lazy.spawn('flameshot full -p {}'.format(str(PARAM.capture_path)))),
    Key([PARAM.mod], 'Print', capture_screen(is_clipboard=False)),
    Key([PARAM.mod, 'shift'], 'Print', capture_screen(is_clipboard=True)),
    # Toggle copyq and calculator
    Key([PARAM.mod], 's', lazy.spawn('copyq toggle')),
    Key([PARAM.mod, 'shift'], 's', lazy.spawn('rofi -show calc -modi calc -no-show-match -no-sort')),
    # Function keys
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%')),
    Key([], 'XF86AudioMute', lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle')),
    Key([], 'XF86AudioMicMute', lazy.spawn('pactl set-source-mute @DEFAULT_SOURCE@ toggle')),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioPause', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('playerctl next')),
    Key([], 'XF86AudioPrev', lazy.spawn('playerctl previous')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('light -A 5')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('light -U 5')),
    Key([], 'XF86KbdBrightnessUp', lazy.spawn('light -Ars {} 1'.format('sysfs/leds/asus::kbd_backlight'))),
    Key([], 'XF86KbdBrightnessDown', lazy.spawn('light -Urs {} 1'.format('sysfs/leds/asus::kbd_backlight'))),
    Key([], 'XF86Launch1', lazy.spawn('sh -c "/home/sumi/bin/swich_gpu_mode"')),
    Key([], 'XF86Launch4', lazy.spawn('asusctl profile -n')),
    # Attach Screen
    KeyChord([PARAM.mod], 'a', [
        Key([], 'k', attach_screen('above')),
        Key([], 'j', attach_screen('below')),
        Key([], 'l', attach_screen('right-of')),
        Key([], 'h', attach_screen('left-of')),
        Key([], 'd', attach_screen('delete')),
        Key([], 'space', lazy.ungrab_chord()),
        ],
        name='attach'
    ),
    # PinP operationes
    KeyChord([PARAM.mod], 'v', [
        Key([], 'k', move_pinp('up')),
        Key([], 'j', move_pinp('down')),
        Key([], 'l', move_pinp('right')),
        Key([], 'h', move_pinp('left')),
        Key([], 'space', lazy.ungrab_chord()),
        ],
        name='pinp'
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
