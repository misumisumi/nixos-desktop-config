{ pkgs, ... }:
let
  font = "Moralerspace Neon";
in
{
  home.packages = [
    pkgs.moralerspace
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        normal = {
          family = font;
          style = "Regular";
        };
        bold = {
          family = font;
          style = "Bold";
        };
        italic = {
          family = font;
          style = "Italic";
        };
        size = 10;
      };
    };
  };
}
