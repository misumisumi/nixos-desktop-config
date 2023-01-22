/*
  Alacritty conf
*/
{ pkgs, ... }:
let
  font = "FiraCode Nerd Font";
  size = 12.0;
  # font = "Ricty Diminished with Fira Code";
  # size = 14.0
in
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
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
            style = "Oblique";
          };
          size = size;
        };
        colors = {
          primary = {
            background = "#1f292e";
            foreground = "#d8e1e6";
          };
          normal = {
            black = "#01060e";
            red = "#ff5252";
            green = "#4db69f";
            yellow = "#c9bc0e";
            blue = "#008fc2";
            magenta = "#cf00ac";
            cyan = "#8BE9FD";
            white = "#cfd8dc";
          };
          bright = {
            black = "#475359";
            red = "#ff4f4d";
            green = "#56d6ba";
            yellow = "#c9c30e";
            blue = "#0095c2";
            magenta = "#9c0082";
            cyan = "#02b7c7";
            white = "#a7b0b5";
          };
        };
      };
    };
  };
}

