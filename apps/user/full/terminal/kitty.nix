# Kitty conf
{ pkgs, ... }:
{
  programs = {
    kitty = {
      enable = true;
      font = {
        package = pkgs.udev-gothic-nf;
        name = "UDEV Gothic NF";
        size = 11;
      };
      settings = {
        font_features = "UDEV Gothic NF +liga +calt +ss01 +ss06 +ss07 +ss08 +ss09";

        ackground = "#282a36";
        background_opacity = "0.80";
        clear_all_shortcuts = "yes";
        enable_audio_bell = "no";

        foreground = "#c0caf5";
        background = "#24283b";
        # Black;
        color0 = "#1d202f";
        color8 = "#414868";
        # Red;
        color1 = "#f7768e";
        color9 = "#f7768e";
        # Green;
        color2 = "#9ece6a";
        color10 = "#9ece6a";
        # Yellow;
        color3 = "#e0af68";
        color11 = "#e0af68";
        # Blue;
        color4 = "#7aa2f7";
        color12 = "#7aa2f7";
        # Magenta;
        color5 = " #bb9af7";
        color13 = "#bb9af7";
        # Cyan;
        color6 = "#7dcfff";
        color14 = "#7dcfff";
        # White;
        color7 = "#a9b1d6";
        color15 = "#c0caf5";
        # Cursor;
        cursor = "#c0caf5";
        cursor_text_color = "#24283b";
        cursor_blink_interval = 0;
        # Selection="highlight";
        selection_foreground = "#c0caf5";
        selection_background = "#364a82";
        # The="color=for=highlighting=URLs=on=mouse-over";
        url_color = "#9ece6a";
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
      keybindings = {
        "ctrl+shift+up" = "scroll_line_up";
        "opt+cmd+up" = "scroll_line_up";
        "cmd+up" = "scroll_line_up";
        "ctrl+shift+down" = "scroll_line_down";
        "opt+cmd+down" = "scroll_line_down";
        "cmd+down" = "scroll_line_down";
        "ctrl+shift+page_up" = "scroll_page_up";
        "cmd+page_up" = "scroll_page_up";
        "ctrl+shift+page_down" = "scroll_page_down";
        "cmd+page_down" = "scroll_page_down";
        "ctrl+shift+home" = "scroll_home";
        "cmd+home" = "scroll_home";
        "ctrl+shift+end" = "scroll_end";
        "cmd+end" = "scroll_end";
        "ctrl+shift+f1" = "show_kitty_doc overview";
        "ctrl+shift+c" = "copy_to_clipboard";
        "cmd+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "cmd+v" = "paste_from_clipboard";
        "ctrl+shift+equal" = "change_font_size all +2.0";
        "cmd+plus" = "change_font_size all +2.0";
        "ctrl+shift+minus" = "change_font_size all -2.0";
        "cmd+minus" = "change_font_size all -2.0";
        "ctrl+shift+backspace" = "change_font_size all 0";
        "cmd+backspace" = "change_font_size all 0";
        "ctrl+shift+e" = "open_url_with_hints";
        "ctrl+shift+delete" = "clear_terminal reset active";
        "opt+cmd+r" = "clear_terminal reset active";
      };
    };
  };
}
