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
        active_tab_font_style = "bold";
        background_opacity = "0.80";
        clear_all_shortcuts = "yes";
        cursor_blink_interval = "0";
        enable_audio_bell = "no";
        font_features = "UDEV Gothic NF +liga +calt +ss01 +ss06 +ss07 +ss08 +ss09";
        inactive_tab_font_style = "bold";
        tab_bar_style = "fade";
        tab_fade = "1";
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
