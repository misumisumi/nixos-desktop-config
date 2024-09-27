# Copyright (c) Connor Holyday <connorholyday@gmail.com> (holyday.me)
# MIT License
# https://github.com/connorholyday/nord-kitty
{
  programs.kitty.settings = {
    font_features = "UDEV Gothic NF +liga +calt +ss01 +ss06 +ss07 +ss08 +ss09";

    ackground = "#282a36";
    background_opacity = "0.80";
    clear_all_shortcuts = "yes";
    enable_audio_bell = "no";

    foreground = "#D8DEE9";
    background = "#2E3440";
    # Black;
    color0 = "#3B4252";
    color8 = "#4C566A";
    # Red;
    color1 = "#BF616A";
    color9 = "#BF616A";
    # Green;
    color2 = "#A3BE8C";
    color10 = "#A3BE8C";
    # Yellow;
    color3 = "#EBCB8B";
    color11 = "#EBCB8B";
    # Blue;
    color4 = "#81A1C1";
    color12 = "#81A1C1";
    # Magenta;
    color5 = " #B48EAD";
    color13 = "#B48EAD";
    # Cyan;
    color6 = "#88C0D0";
    color14 = "#8FBCBB";
    # White;
    color7 = "#E5E9F0";
    color15 = "#ECEFF4";
    # Cursor;
    cursor = "#81A1C1";
    cursor_text_color = "#24283b";
    cursor_blink_interval = 0;
    # Selection="highlight";
    selection_foreground = "#000000";
    selection_background = "#FFFACD";
    # The="color=for=highlighting=URLs=on=mouse-over";
    url_color = "#0087BD";
    # Window="borders";
    active_border_color = "#3d59a1";
    inactive_border_color = "#101014";
    bell_border_color = "#e0af68";
    # Tab="bar";
    tab_bar_style = "fade";
    tab_fade = "1";
    active_tab_foreground = "#3d59a1";
    active_tab_background = "#1f2335";
    active_tab_font_style = "bold";
    inactive_tab_foreground = "#787c99";
    inactive_tab_background = "#1f2335";
    inactive_tab_font_style = "bold";
    tab_bar_background = "#101014";
    # Title="bar";
    macos_titlebar_color = "#1f2335";
  };
}
