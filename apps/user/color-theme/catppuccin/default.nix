{
  pkgs,
  lib,
  config,
  scheme ? "small",
  ...
}:
{
  catppuccin = {
    flavor = "mocha";
    pointerCursor.enable = true;
  };
  programs = {
    alacritty.catppuccin.enable = true;
    bat.catppuccin.enable = true;
    btop.catppuccin.enable = true;
    git.delta.catppuccin.enable = true;
    kitty.catppuccin.enable = true;
    obs-studio.catppuccin.enable = true;
    starship = {
      catppuccin.enable = true;
      settings = {
        palettes.catppuccin_mocha =
          let
            palette =
              (lib.importTOML "${config.catppuccin.sources.starship}/themes/mocha.toml")
              .palettes.catppuccin_mocha;
          in
          {
            terminal_dark = palette.base;
            fg = palette.text;
            magenta2 = palette.maroon;
            green1 = palette.teal;
          };
      };
    };
    yazi.catppuccin.enable = true;
    zathura.catppuccin.enable = true;
  };
  services = {
    dunst.catppuccin.enable = true;
  };
  gtk.theme = {
    name = "Catppuccin-GTK-Dark";
    package = pkgs.magnetic-catppuccin-gtk;
  };
}
// lib.optionals (scheme == "full") {
  i18n.inputMethod.fcitx5.addons = with pkgs; [ catppuccin-fcitx5 ];
  xdg.configFile = {
    "wezterm/color-scheme.lua".source = ./wezterm/color-scheme.lua;
    "qtile/my_modules/colorset.py".source = ./qtile/colorset.py;
  };
}
