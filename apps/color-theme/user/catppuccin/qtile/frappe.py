from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#303446"
    foreground: str = "#c6d0f5"

    black: str = "#51576d"
    red: str = "#e78284"
    green: str = "#a6d189"
    yellow: str = "#e5c890"
    blue: str = "#8caaee"
    magenta: str = "#f4b8e4"
    cyan: str = "#81c8be"
    white: str = "#b5bfe2"

    bblack: str = "#626880"
    bred: str = "#e78284"
    bgreen: str = "#a6d189"
    byellow: str = "#e5c890"
    bblue: str = "#8caaee"
    bmagenta: str = "#f4b8e4"
    bcyan: str = "#81c8be"
    bwhite: str = "#a5adce"

    accent: str = "#ca9ee6"
