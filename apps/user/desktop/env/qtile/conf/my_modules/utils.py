import subprocess
from pathlib import Path

from libqtile.log_utils import logger


def get_n_monitors() -> str:
    cmd = [r"xrandr --listactivemonitors | head -n1 | awk -F' ' '{print $2}'"]
    num_monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.replace("\n", "")
    num_monitors = int(num_monitors)

    return num_monitors


def get_phy_monitors() -> list[tuple[str, tuple[str]]]:
    xrandr = "xrandr --listactivemonitors"
    cmd = (
        xrandr
        + r" | tail -n+2 | awk -F' ' '{print $2,$3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/' | sed -E 's/\+\*?//g'"
    )
    cmd_result = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    monitors = [
        (output, tuple(map(lambda x: int(x), resolution.split("x"))))
        for output, resolution in map(lambda x: x.split(" "), cmd_result)
    ]

    return monitors


def have_pentablet(pentab_output_name: str) -> tuple[int, str] | None:
    xrandr = "xrandr --listactivemonitors"
    cmd = (
        xrandr
        + r" | tail -n+2 | awk -F' ' '{print $2,$3}' | sed 's/\(.*\)\/.*x\(.*\)\/.*$/\1x\2/' | sed -E 's/\+\*?//g'"
    )
    cmd_result = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.split("\n")[:-1]
    for i, (output, resolution) in enumerate(map(lambda x: x.split(" "), cmd_result)):
        logger.warning(f"Output: {output}, Resolution: {resolution}")
        if pentab_output_name == output:
            return (i, pentab_output_name)

    return None


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
