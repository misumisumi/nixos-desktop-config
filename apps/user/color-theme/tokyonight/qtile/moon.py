from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#222436"
    foreground: str = "#c8d3f5"

    black: str = "#1b1d2b"
    red: str = "#ff757f"
    green: str = "#c3e88d"
    yellow: str = "#ffc777"
    blue: str = "#82aaff"
    magenta: str = "#c099ff"
    cyan: str = "#86e1fc"
    white: str = "#828bb8"

    bblack: str = "#444a73"
    bred: str = "#ff757f"
    bgreen: str = "#c3e88d"
    byellow: str = "#ffc777"
    bblue: str = "#82aaff"
    bmagenta: str = "#c099ff"
    bcyan: str = "#86e1fc"
    bwhite: str = "#c8d3f5"
