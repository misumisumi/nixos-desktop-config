from dataclasses import dataclass


@dataclass
class ColorSet:
    # define nord
    background: str = "#2e3440"
    foreground: str = "#d8dee9"
    transparent: str = "#00000000"

    black: str = "#3b4252"
    red: str = "#bf616a"
    green: str = "#a3be8c"
    yellow: str = "#ebcb8b"
    blue: str = "#81a1c1"
    magenta: str = "#b48ead"
    cyan: str = "#88c0d0"
    white: str = "#e5e9f0"

    bblack: str = "#4c566a"
    bred: str = "#bf616a"
    bgreen: str = "#a3be8c"
    byellow: str = "#ebcb8b"
    bblue: str = "#81a1c1"
    bmagenta: str = "#b48ead"
    bcyan: str = "#8fbcbb"
    bwhite: str = "#eceff4"

    accent: str = cyan
