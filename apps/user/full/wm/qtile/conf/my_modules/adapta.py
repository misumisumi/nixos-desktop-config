from dataclasses import dataclass


@dataclass
class ColorSet:
    # define adapta-nokto
    background: str = "#15161e"
    foreground: str = "#475359"

    black: str = "#01060e"
    red: str = "#ff5252"
    green: str = "#4db69f"
    yellow: str = "#c9bc0e"
    blue: str = "#008fc2"
    magenta: str = "#cf00ac"
    cyan: str = "#02adc7"
    white: str = "#cfd8dc"

    bblack: str = "#475359"
    bred: str = "#ff5252"
    bgreen: str = "#4db69f"
    byellow: str = "#c9bc0e"
    bblue: str = "#008fc2"
    bmagenta: str = "#cf00ac"
    bcyan: str = "#02adc7"
    bwhite: str = "#a7b0b5"
