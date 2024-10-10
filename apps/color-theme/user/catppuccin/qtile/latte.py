from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#eff1f5"
    foreground: str = "#4c4f69"

    black: str = "#bcc0cc"
    red: str = "#d20f39"
    green: str = "#40a02b"
    yellow: str = "#df8e1d"
    blue: str = "#1e66f5"
    magenta: str = "#ea76cb"
    cyan: str = "#179299"
    white: str = "#5c5f77"

    bblack: str = "#acb0be"
    bred: str = "#d20f39"
    bgreen: str = "#40a02b"
    byellow: str = "#df8e1d"
    bblue: str = "#1e66f5"
    bmagenta: str = "#ea76cb"
    bcyan: str = "#179299"
    bwhite: str = "#6c6f85"

    accent: str = "#8839ef"
