/*
  Kitty conf
*/
{ pkgs, ... }:
let
  font = "FiraCode Nerd Font";
  size = 12;
in
{
  programs = {
    kitty = {
      enable = true;
      font = {
        package = (pkgs.nerdfonts.override {
          # Nerdfont override
          fonts = [
            "FiraCode"
            "Hack"
          ];
        });
        name = font;
        size = size;
      };
      settings = {
        foreground = "#d8e1e6";
        background = "#1f292e";
        background_opacity = "0.85";
        clear_all_shortcuts = "yes";
        enable_audio_bell = "no";
      };
      keybindings = {
        "ctrl+shift+up" = "scroll_line_up";
        "opt+cmd+up" = "scroll_line_up";
        "cmd+up" = "scroll_line_up";
        "ctrl+shift+donw" = "scroll_line_donw";
        "opt+cmd+donw" = "scroll_line_donw";
        "cmd+donw" = "scroll_line_donw";
        "ctrl+shift+page_up" = "scroll_page_up";
        "cmd+page_up" = "scroll_page_up";
        "ctrl+shift+page_donw" = "scroll_page_donw";
        "cmd+page_donw" = "scroll_page_donw";
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

