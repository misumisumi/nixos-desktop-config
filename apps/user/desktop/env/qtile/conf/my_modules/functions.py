"""custom function for qtile"""

import asyncio
import subprocess

from libqtile import hook, qtile
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from my_modules import groups, screens, startup, wallpaper
from my_modules.colorset import ColorSet
from my_modules.groups import GROUP_PER_SCREEN, group_and_rule
from my_modules.utils import get_monitor_status
from my_modules.variables import GlobalConf, PinPConf, WindowConf

PINP_WINDOW = None
FLOATING_WINDOW_IDX = 0


# PinPの生成時とWS切替時にフォーカスを当てないようにする
def keep_focus_window_in_tiling(window=None):
    if window is None:
        for window in qtile.current_group.windows:
            if not window.floating:
                break
    qtile.current_group.focus(window, True)


def get_pinp_size_pos(init=True):
    screen_size = (qtile.current_screen.width, qtile.current_screen.height)
    screen_pos = (qtile.current_screen.x, qtile.current_screen.y)
    pinp_size = [int(s // PinPConf.pinp_scale_down) for s in screen_size]
    pinp_pos = [ss + sp - p for ss, sp, p in zip(screen_size, screen_pos, pinp_size)]
    pinp_pos[0] = pinp_pos[0] - PinPConf.margin - WindowConf.border

    return pinp_size, pinp_pos


# 一部のソフトは起動直後はwindow nameを出さないため数msのdelayを設ける
@hook.subscribe.client_new
async def move_speclific_apps(window):
    await asyncio.sleep(0.01)
    if window.name.split(" - ")[-1] in PinPConf.target_cls_name:
        # 画面サイズに合わせて自動的にPinPのサイズとポジションを決定する
        pinp_size, pinp_pos = get_pinp_size_pos()

        global PINP_WINDOW
        idx = qtile.current_screen.index
        PINP_WINDOW = {"idx": idx, "window": window}

        window.place(
            *pinp_pos,
            *pinp_size,
            borderwidth=WindowConf.border,
            bordercolor=ColorSet.cyan,
            above=False,
            margin=None,
        )
        keep_focus_window_in_tiling()
    elif window.name == "WaveSurfer 1.8.8p5":
        window.togroup("0-analyze")
    elif PINP_WINDOW is not None:
        PINP_WINDOW["window"].bring_to_front()


@hook.subscribe.client_killed
def remove_pinp_by_kill(window):
    global PINP_WINDOW
    if PINP_WINDOW is not None and window == PINP_WINDOW["window"]:
        PINP_WINDOW = None


@hook.subscribe.float_change
def remove_pinp_by_toggle_float():
    floating_windows = []
    for window in qtile.current_group.windows:
        if window.floating:
            floating_windows.append(window)
    global PINP_WINDOW
    if PINP_WINDOW is not None and PINP_WINDOW["window"] not in floating_windows:
        PINP_WINDOW = None


@lazy.function
def force_pinp(qtile):
    """
    強制的にPinPにする
    ただし、PINP_WINDOWがない場合に限る
    """
    global PINP_WINDOW
    if PINP_WINDOW is None:
        pinp_size, pinp_pos = get_pinp_size_pos()

        idx = qtile.current_screen.index
        window = qtile.current_window
        window.toggle_floating()
        window.place(
            *pinp_pos,
            *pinp_size,
            borderwidth=WindowConf.border,
            bordercolor=ColorSet.cyan,
            above=False,
            margin=None,
        )
        PINP_WINDOW = {"idx": idx, "window": window}
        keep_focus_window_in_tiling()


@lazy.function
def keep_pinp(qtile):
    """
    workspaceを跨いでもPinPが同じ位置に表示されるようにする
    """
    if PINP_WINDOW is not None:
        now_pinp_screen = PINP_WINDOW["idx"]
        idx = qtile.current_screen.index
        win = qtile.current_window
        if now_pinp_screen == idx:
            PINP_WINDOW["window"].togroup(qtile.current_screen.group.name)
            PINP_WINDOW["window"].bring_to_front()
            keep_focus_window_in_tiling(win)


@lazy.function
def update_pinp_screen_idx(qtile):
    global PINP_WINDOW
    if PINP_WINDOW is not None:
        idx = qtile.current_screen.index
        win = qtile.current_window
        if PINP_WINDOW["idx"] != idx and win == PINP_WINDOW["window"]:
            PINP_WINDOW["idx"] = idx


@lazy.function
def move_pinp(qtile, pos):
    """
    モニターの四隅にPinP windowを移動できるようにする
    """
    idx = qtile.current_screen.index
    if PINP_WINDOW is not None and idx == PINP_WINDOW["idx"]:
        screen_size = (qtile.current_screen.width, qtile.current_screen.height)
        screen_pos = (qtile.current_screen.x, qtile.current_screen.y)
        pinp_size = [int(s // PinPConf.pinp_scale_down) for s in screen_size]
        pinp_pos = [PINP_WINDOW["window"].float_x, PINP_WINDOW["window"].float_y]

        if pos == "up":
            pinp_pos[1] = 0
        elif pos == "down":
            pinp_pos[1] = screen_size[1] - pinp_size[1] - PinPConf.margin
        elif pos == "left":
            pinp_pos[0] = PinPConf.margin
        else:
            pinp_pos[0] = screen_size[0] - pinp_size[0] - PinPConf.margin
        pinp_pos[0] += screen_pos[0]
        pinp_pos[1] += screen_pos[1]

        win = qtile.current_window
        PINP_WINDOW["window"].place(
            *pinp_pos,
            *pinp_size,
            borderwidth=WindowConf.border,
            bordercolor=ColorSet.cyan,
            above=False,
            margin=None,
        )
        PINP_WINDOW["window"].bring_to_front()
        keep_focus_window_in_tiling(win)


# floating windowは次に生成されたwindowの下にいきfocusが当てられないことへの回避策
@lazy.function
def float_cycle(qtile, forward: bool, focus=False):
    global FLOATING_WINDOW_IDX
    floating_windows = []
    for window in qtile.current_group.windows:
        if window.floating:
            floating_windows.append(window)
    if floating_windows:
        FLOATING_WINDOW_IDX = min(FLOATING_WINDOW_IDX, len(floating_windows) - 1)
        if forward:
            FLOATING_WINDOW_IDX += 1
        else:
            FLOATING_WINDOW_IDX += 1
        if FLOATING_WINDOW_IDX >= len(floating_windows):
            FLOATING_WINDOW_IDX = 0
        if FLOATING_WINDOW_IDX < 0:
            FLOATING_WINDOW_IDX = len(floating_windows) - 1
        win = floating_windows[FLOATING_WINDOW_IDX]
        win.bring_to_front()
        if focus:
            qtile.current_group.focus(win, True)


def check_screen(idx, min_idx, max_idx):
    return min_idx <= idx < max_idx


def calc_range_idx(current_screen_idx):
    """
    あるモニターに所属している先頭と末尾のグループのidxを取得
    """
    min_idx = GROUP_PER_SCREEN * current_screen_idx
    max_idx = GROUP_PER_SCREEN * (current_screen_idx + 1)
    return min_idx, max_idx


"""
各モニターに同じだけのワークスペースを割り当て、モニターを跨いでのfocusとmoveを許可しない
これはxmonadのworkspaceの挙動を再現
ex):
    monitor1 = [ws0, ws1]
    monitor2 = [ws2, ws3]
    if focus == monitor1:
        allow cycle focus and move between ws0 and ws1. (in monitor1)
    else:
        allow cycle focus and move between ws2 and ws3. (in monitor2)
"""


@lazy.function
def focus_previous_group(qtile):
    group = qtile.current_screen.group
    group_index = qtile.groups.index(group)

    previous_group = group.get_previous_group(skip_empty=True)
    previous_group_index = qtile.groups.index(previous_group)

    idx = qtile.current_screen.index
    min_idx, max_idx = calc_range_idx(idx)
    check = check_screen(previous_group_index, min_idx, max_idx)

    if previous_group_index < group_index and check:
        qtile.current_screen.set_group(previous_group)


@lazy.function
def focus_next_group(qtile):
    group = qtile.current_screen.group
    group_index = qtile.groups.index(group)

    next_group = group.get_next_group(skip_empty=True)
    next_group_index = qtile.groups.index(next_group)

    idx = qtile.current_screen.index
    min_idx, max_idx = calc_range_idx(idx)
    check = check_screen(next_group_index, min_idx, max_idx)

    if next_group_index > group_index and check:
        qtile.current_screen.set_group(next_group)


@lazy.function
def window_to_previous_group(qtile):
    group = qtile.current_screen.group
    group_index = qtile.groups.index(group)

    previous_group = group.get_previous_group(skip_empty=False)
    previous_group_index = qtile.groups.index(previous_group)

    idx = qtile.current_screen.index
    min_idx, max_idx = calc_range_idx(idx)
    check = check_screen(previous_group_index, min_idx, max_idx)

    if previous_group_index < group_index and check:
        qtile.current_window.togroup(previous_group.name, switch_group=True)


@lazy.function
def window_to_next_group(qtile):
    group = qtile.current_screen.group
    group_index = qtile.groups.index(group)

    next_group = group.get_next_group(skip_empty=False)
    next_group_index = qtile.groups.index(next_group)

    idx = qtile.current_screen.index
    min_idx, max_idx = calc_range_idx(idx)
    check = check_screen(next_group_index, min_idx, max_idx)
    if next_group_index > group_index and check:
        qtile.current_window.togroup(next_group.name, switch_group=True)


@lazy.function
def focus_n_screen_group(qtile, idx):
    groups = qtile.groups
    s_idx = qtile.current_screen.index
    if s_idx < GlobalConf.monitors and idx < GROUP_PER_SCREEN:
        qtile.current_screen.set_group(groups[int(idx + GROUP_PER_SCREEN * s_idx)])


@lazy.function
def move_n_screen_group(qtile, idx):
    groups = qtile.groups
    s_idx = qtile.current_screen.index
    if s_idx < GlobalConf.monitors and idx < GROUP_PER_SCREEN:
        qtile.current_window.togroup(groups[int(idx + GROUP_PER_SCREEN * s_idx)].name, switch_group=True)


@lazy.function
def focus_cycle_screen(qtile, backward=False, pentablet=False):
    idx = qtile.current_screen.index
    monitors = GlobalConf.monitors
    if pentablet:
        if idx < monitors:
            to_idx = monitors
        else:
            to_idx = monitors - 1 if backward else 0
    else:
        if backward:
            to_idx = monitors - 1 if idx == 0 else idx - 1
        else:
            to_idx = 0 if idx + 1 >= monitors else idx + 1
    qtile.to_screen(to_idx)


@lazy.function
def move_cycle_screen(qtile, backward=False):
    idx = qtile.current_screen.index
    monitors = GlobalConf.monitors
    if idx <= monitors:
        if backward:
            to_idx = monitors - 1 if idx == 0 else idx - 1
            to_group = qtile.groups.index(qtile.current_screen.group) - GROUP_PER_SCREEN
            to_group = to_group if to_group >= 0 else to_group + (GROUP_PER_SCREEN * monitors)

        else:
            to_idx = 0 if idx + 1 >= monitors else idx + 1
            to_group = qtile.groups.index(qtile.current_screen.group) + GROUP_PER_SCREEN
            to_group = to_group if to_group < GROUP_PER_SCREEN * monitors else to_group - (GROUP_PER_SCREEN * monitors)
        group = qtile.groups[to_group]
        qtile.current_window.togroup(group.name)
        qtile.to_screen(to_idx)
        qtile.current_screen.set_group(group)


@lazy.function
def to_from_pentablet(qtile):
    idx = qtile.current_screen.index
    monitors = GlobalConf.monitors
    if idx == monitors:
        to_idx = list(group_and_rule.keys()).index("full")
        group = qtile.groups[to_idx]
        qtile.current_window.togroup(group.name)
        qtile.to_screen(0)
        qtile.current_screen.set_group(group)
    else:
        qtile.current_window.togroup(qtile.groups[-2].name)
        qtile.to_screen(monitors)


@lazy.function
def capture_screen(qtile, is_clipboard=False):
    idx = qtile.current_screen.index
    if is_clipboard:
        qtile.spawn(f"flameshot screen -n {idx} -c")
    else:
        qtile.spawn(f"flameshot screen -n {idx}")


@lazy.function
def reload_config_alt(qtile):
    wallpaper.mk_wallpaper_cache()
    qtile.reload_config()


def _reload_screens(qtile):
    GlobalConf.update_monitors()
    qtile.config.screens = screens.make_screens(manually=True)
    qtile.config.groups = groups.set_groups()
    qtile.reconfigure_screens()


@lazy.function
def reload_screens(qtile):
    _reload_screens(qtile)


@hook.subscribe.screens_reconfigured
async def reinit_screen():
    await asyncio.sleep(0.6)
    screens.set_bar_property()
    wallpaper.mk_wallpaper_cache()
    qtile.reload_config()
    startup.autostart()


@lazy.function
def attach_screen(qtile, pos):
    cmd = "xrandr"
    if pos == "delete":
        monitor_status = get_monitor_status()
        conn = monitor_status["connected"]
        if len(conn) > 1:
            cmd += f" --output {conn[-1]} --off"
    else:
        monitor_status = get_monitor_status()
        conn = monitor_status["connected"]
        for i, monitor in enumerate(conn):
            cmd += f" --output {monitor} --auto"
            if i > 0:
                cmd += f" --{pos} {conn[i-1]}"
        discon = monitor_status["disconnected"]
        if len(discon) > 0:
            cmd += f" --output {discon[0]} --auto --{pos} {conn[i-1]}"
    popen = subprocess.Popen(cmd, shell=True)
    popen.wait(timeout=5)
    _reload_screens(qtile)
