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
        package = (pkgs.nerdfonts.override {                   # Nerdfont override
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
        # clear_all_shortcuts = "yes";
      };
    };
  };
}

