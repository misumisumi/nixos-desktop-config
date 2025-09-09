"""set wallpaper"""

import subprocess
from shutil import which

from libqtile import hook, qtile
from libqtile.log_utils import logger
from my_modules.groups import group_and_rule
from my_modules.variables import GlobalConf

MONITORS = {}
horiz_wallpaper = []
verti_wallpaper = []
num_horiz_wallpaper = 0
num_verti_wallpaper = 0
for i in range(GlobalConf.monitors):
    MONITORS[i] = 0


def get_direction(screen):
    width, height = screen.width, screen.height
    direction = "_verti" if width < height else "_horiz"

    return direction


# 壁紙の割当(ラップトップはバッテリーの観点から固定)
if not GlobalConf.laptop:

    @hook.subscribe.setgroup
    def change_wallpaper():
        global MONITORS, horiz_wallpaper, verti_wallpaper, num_horiz_wallpaper, num_verti_wallpaper
        feh = "feh --no-fehbg " + r" --bg-fill {}" * len(qtile.screens)
        group = qtile.current_screen.group
        gidx = qtile.groups.index(group)
        if qtile.current_screen in qtile.screens:
            idx = qtile.screens.index(qtile.current_screen)
            direc = get_direction(qtile.current_screen)
            n_groups = len(group_and_rule)
            if gidx >= n_groups:
                gidx -= n_groups * idx
            if direc == "_verti":
                MONITORS[idx] = gidx if gidx < num_verti_wallpaper else 0
            else:
                MONITORS[idx] = gidx if gidx < num_horiz_wallpaper else 0
            bgs = []
            for screen in qtile.screens:
                direc = get_direction(screen)
                if screen.index >= len(MONITORS.keys()):
                    widx = 0
                elif direc == "_horiz" and idx > num_horiz_wallpaper:
                    widx = 0
                elif direc == "_verti" and idx > num_verti_wallpaper:
                    widx = 0
                else:
                    widx = MONITORS[screen.index]
                if direc == "_verti":
                    fname = verti_wallpaper[widx]
                else:
                    fname = horiz_wallpaper[widx]
                bgs.append(fname)
            subprocess.run(feh.format(*bgs), shell=True)


def init_screen_wallpapers():
    feh = "feh --no-fehbg "
    global horiz_wallpaper, verti_wallpaper, num_horiz_wallpaper, num_verti_wallpaper
    for screen in qtile.screens:
        direc = get_direction(screen)
        if direc == "_verti":
            idx = screen.index if screen.index < num_verti_wallpaper else 0
            fname = verti_wallpaper[idx]
        else:
            idx = screen.index if screen.index < num_horiz_wallpaper else 0
            fname = horiz_wallpaper[idx]
        feh += f" --bg-fill {fname}"
    subprocess.run(feh, shell=True)


def mk_wallpaper_cache():
    """
    Create wallpaper cache.
    Delete XDG_CACHE_DIR/qtile/wallpapers when updating the cache.
    """
    global horiz_wallpaper, verti_wallpaper, num_horiz_wallpaper, num_verti_wallpaper
    cmd = "gm convert" if which("gm") else "convert"
    for screen in qtile.screens:
        width, height = screen.width, screen.height
        direc = get_direction(screen)
        wallpapers = filter(lambda x: direc in x.name, GlobalConf.wallpapers)
        for wallpaper in wallpapers:
            if GlobalConf.use_cached_wallpapers:
                cached = GlobalConf.wallpapers_cache_path.joinpath(f"{screen.index}_{wallpaper.name}")
                if not cached.exists():
                    subprocess.run(f"{cmd} {wallpaper} -resize {width}x{height} {cached}", shell=True)
            else:
                cached = wallpaper
            if direc == "_verti":
                verti_wallpaper.append(cached)
            else:
                horiz_wallpaper.append(cached)
    num_verti_wallpaper = len(verti_wallpaper)
    num_horiz_wallpaper = len(horiz_wallpaper)
