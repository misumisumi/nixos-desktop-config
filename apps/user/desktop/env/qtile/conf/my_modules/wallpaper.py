"""set wallpaper"""

import subprocess
from shutil import which

from libqtile import hook, qtile
from libqtile.log_utils import logger

from my_modules.groups import group_and_rule
from my_modules.variables import GlobalConf

MONITORS = {}
for i in range(GlobalConf.monitors):
    MONITORS[i] = 0


# 壁紙の割当(ラップトップはバッテリーの観点から固定)
if not GlobalConf.laptop:

    @hook.subscribe.setgroup
    def change_wallpaper():
        global MONITORS
        feh = "feh --no-fehbg " + r" --bg-fill {}" * len(qtile.screens)
        group = qtile.current_screen.group
        gidx = qtile.groups.index(group)
        if qtile.current_screen in qtile.screens:
            idx = qtile.screens.index(qtile.current_screen)
            n_groups = len(group_and_rule)
            if gidx >= n_groups:
                gidx -= n_groups * idx
            MONITORS[idx] = gidx if gidx < len(GlobalConf.wallpapers) else 0
            bgs = []
            for screen in qtile.screens:
                if screen.index >= len(MONITORS.keys()):
                    widx = 0
                elif idx >= len(GlobalConf.wallpapers):
                    widx = 0
                else:
                    widx = MONITORS[screen.index]
                fname = GlobalConf.wallpapers[widx].name
                bgfname = f"{screen.index}_{fname}" if GlobalConf.use_cached_wallpapers else f"{fname}"
                bg = GlobalConf.wallpapers_cache_path.joinpath(bgfname)
                bgs.append(bg)
            subprocess.run(feh.format(*bgs), shell=True)


def init_screen_wallpapers():
    feh = "feh --no-fehbg "
    for screen in qtile.screens:
        idx = screen.index if screen.index < len(GlobalConf.wallpapers) else 0
        fname = GlobalConf.wallpapers[idx].name
        bgfname = f"{screen.index}_{fname}" if GlobalConf.use_cached_wallpapers else f"{fname}"
        bg = GlobalConf.wallpapers_cache_path.joinpath(bgfname)
        feh += f" --bg-fill {bg}"
    subprocess.run(feh, shell=True)


def mk_wallpaper_cache():
    """
    Create wallpaper cache.
    Delete XDG_CACHE_DIR/qtile/wallpapers when updating the cache.
    """
    if GlobalConf.use_cached_wallpapers:
        cmd = "gm convert" if which("gm") else "convert"
        for screen in qtile.screens:
            width, height = screen.width, screen.height
            for wallpaper in GlobalConf.wallpapers:
                cached = GlobalConf.wallpapers_cache_path.joinpath(f"{screen.index}_{wallpaper.name}")
                if not cached.exists():
                    subprocess.run(f"{cmd} {wallpaper} -resize {width}x{height} {cached}", shell=True)
