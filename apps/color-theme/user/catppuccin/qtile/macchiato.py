from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#24273a"
    foreground: str = "#cad3f5"

    black: str = "#494d64"
    red: str = "#ed8796"
    green: str = "#a6da95"
    yellow: str = "#eed49f"
    blue: str = "#8aadf4"
    magenta: str = "#f5bde6"
    cyan: str = "#8bd5ca"
    white: str = "#b8c0e0"

    bblack: str = "#5b6078"
    bred: str = "#ed8796"
    bgreen: str = "#a6da95"
    byellow: str = "#eed49f"
    bblue: str = "#8aadf4"
    bmagenta: str = "#f5bde6"
    bcyan: str = "#8bd5ca"
    bwhite: str = "#a5adcb"

    accent: str = "#c6a0f6"
