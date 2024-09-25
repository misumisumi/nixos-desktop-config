import subprocess
from pathlib import Path


def get_n_monitors(has_pentablet: bool) -> str:
    cmd = [r"xrandr --listactivemonitors | head -n1 | awk -F' ' '{print $2}'"]
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.replace("\n", "")
    monitors = int(monitors)
    if has_pentablet:
        monitors -= 1

    return monitors


def get_phy_monitors(has_pentablet: bool, activate_only: bool = False) -> list[tuple[str, tuple[str]]]:
    xrandr = "xrandr --listactivemonitors" if activate_only else "xrandr --listmonitors"
    cmd = [
        xrandr
        + r" | tail -n+2 | awk -F' ' '{print $2,$3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/' | sed -E 's/\+\*?//g'"
    ]
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    monitors = [(output, tuple(resolution.split("x"))) for output, resolution in map(lambda x: x.split(" "), monitors)]
    if has_pentablet:
        monitors = monitors[:-1]

    return monitors


def get_wallpapers(home: Path, laptop: bool) -> list[str]:
    if laptop:
        wallpapers = list(home.joinpath("Pictures", "wallpapers", "fixed").glob("*.png"))
    else:
        wallpapers = list(home.joinpath("Pictures", "wallpapers", "unfixed").glob("*.png"))
    wallpapers.sort()

    return [str(wallpaper) for wallpaper in wallpapers]
