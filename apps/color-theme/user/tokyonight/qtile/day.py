from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#e1e2e7"
    foreground: str = "#3760bf"

    black: str = "#b4b5b9"
    red: str = "#f52a65"
    green: str = "#587539"
    yellow: str = "#8c6c3e"
    blue: str = "#2e7de9"
    magenta: str = "#9854f1"
    cyan: str = "#007197"
    white: str = "#6172b0"

    bblack: str = "#a1a6c5"
    bred: str = "#f52a65"
    bgreen: str = "#587539"
    byellow: str = "#8c6c3e"
    bblue: str = "#2e7de9"
    bmagenta: str = "#9854f1"
    bcyan: str = "#007197"
    bwhite: str = "#3760bf"

    accent: str = foreground
