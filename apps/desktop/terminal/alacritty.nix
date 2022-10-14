{ pkgs, ... }:
let
  font = "FiraCode Nerd Font";
  # font = "Ricty Diminished with Fira Code";
in
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
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
          size = 16.0;
        };
        colors = {
          primary = {
            background = "0x1f292e";
            foreground = "0xd8e1e6";
          };
          normal = {
            black = "0x01060e";
            red = "0xff5252";
            green = "0x4db69f";
            yellow = "0xc9bc0e";
            blue = "0x008fc2";
            magenta = "0xcf00ac";
            cyan = "0x02adc7";
            white = "0xcfd8dc";
          };
          bright = {
            black = "0x475359";
            red = "0xff4f4d";
            green = "0x56d6ba";
            yellow = "0xc9c30e";
            blue = "0x0095c2";
            magenta = "0x9c0082";
            cyan = "0x02b7c7";
            white = "0xa7b0b5";
          };
        };
      };
    };
  };
}

