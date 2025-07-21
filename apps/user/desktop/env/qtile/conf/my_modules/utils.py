import subprocess
from pathlib import Path


def get_n_monitors(has_pentablet: bool) -> str:
    cmd = [r"xrandr --listactivemonitors | head -n1 | awk -F' ' '{print $2}'"]
    num_monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.replace("\n", "")
    num_monitors = int(num_monitors)
    if has_pentablet:
        num_monitors -= 1

    return num_monitors


def get_phy_monitors(has_pentablet: bool) -> list[tuple[str, tuple[str]]]:
    xrandr = "xrandr --listactivemonitors"
    cmd = (
        xrandr
        + r" | tail -n+2 | awk -F' ' '{print $2,$3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/' | sed -E 's/\+\*?//g'"
    )
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    monitors = [
        (output, tuple(map(lambda x: int(x), resolution.split("x"))))
        for output, resolution in map(lambda x: x.split(" "), monitors)
    ]
    if has_pentablet:
        monitors = monitors[:-1]

    return monitors


def get_monitor_status() -> dict:
    status = {}

    xrandr = "xrandr"
    connected = xrandr + r" | grep connected | awk -F' ' '{print $1}'"
    status["connected"] = subprocess.run(connected, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    disconnected = xrandr + r" | grep disconnected | awk -F' ' '{print $1}'"
    status["disconnected"] = subprocess.run(disconnected, shell=True, capture_output=True, text=True).stdout.split(
        "\n"
    )[:-1]

    return status


def get_wallpapers(path: Path, laptop: bool) -> list[str]:
    if laptop:
        wallpapers = list(path.joinpath("fixed").glob("*.png"))
    else:
        wallpapers = list(path.joinpath("unfixed").glob("*.png"))
    wallpapers.sort()

    return wallpapers
