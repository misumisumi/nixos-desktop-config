from dataclasses import dataclass


@dataclass
class ColorSet:
    transparent: str = "#00000000"

    background: str = "#1e1e2e"
    foreground: str = "#cdd6f4"

    black: str = "#45475a"
    red: str = "#f38ba8"
    green: str = "#a6e3a1"
    yellow: str = "#f9e2af"
    blue: str = "#89b4fa"
    magenta: str = "#f5c2e7"
    cyan: str = "#94e2d5"
    white: str = "#bac2de"

    bblack: str = "#585b70"
    bred: str = "#f38ba8"
    bgreen: str = "#a6e3a1"
    byellow: str = "#f9e2af"
    bblue: str = "#89b4fa"
    bmagenta: str = "#f5c2e7"
    bcyan: str = "#94e2d5"
    bwhite: str = "#a6adc8"
