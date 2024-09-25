from dataclasses import dataclass


@dataclass
class ColorSet:
    # define tokyo-night
    background: str = "#1a1b26"
    foreground: str = "#c0caf5"

    transparent: str = "#00000000"

    black: str = "#15161e"
    red: str = "#f7768e"
    green: str = "#9ece6a"
    yellow: str = "#e0af68"
    blue: str = "#7aa2f7"
    magenta: str = "#bb9af7"
    cyan: str = "#7dcfff"
    white: str = "#a9b1d6"

    bblack: str = "#414868"
    bred: str = "#f7768e"
    bgreen: str = "#9ece6a"
    byellow: str = "#e0af68"
    bblue: str = "#7aa2f7"
    bmagenta: str = "#bb9af7"
    bcyan: str = "#7dcfff"
    bwhite: str = "#c0caf5"
