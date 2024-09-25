import subprocess

from my_modules.variables import GlobalConf


def get_n_screen() -> str:
    cmd = [r"xrandr --listactivemonitors | head -n1 | awk -F' ' '{print $2}'"]
    monitors = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.replace("\n", "")
    monitors = int(monitors)
    if GlobalConf.has_pentablet:
        monitors -= 1

    return monitors
