{
  pkgs,
  lib,
  config,
  scheme ? "small",
  colorTheme ? "catppuccin-macchiato",
  ...
}:
let
  flavor = builtins.replaceStrings [ "catppuccin-" ] [ "" ] colorTheme;
in
{
  catppuccin = {
    inherit flavor;
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
        palettes."catppuccin_${flavor}" =
          let
            palette =
              (lib.importTOML "${config.catppuccin.sources.starship}/themes/${flavor}.toml")
              .palettes."catppuccin_${flavor}";
          in
          {
            bg = palette.base;
            terminal_dark = palette.surface0;
            fg = palette.text;
            magenta = palette.maroon;
            cyan = palette.teal;
          };
      };
    };
    yazi.catppuccin.enable = true;
    zathura.catppuccin.enable = true;
  };
  services = {
    dunst.catppuccin.enable = true;
  };
}
// lib.optionals (scheme == "full") {
  i18n.inputMethod.fcitx5.catppuccin.enable = true;
  gtk = {
    theme =
      let
        shade = if flavor == "latte" then "Light" else "Dark";
      in
      {
        name = "Catppuccin-GTK-${shade}";
        package = pkgs.magnetic-catppuccin-gtk.override { shade = lib.toLower shade; };
      };
  };
  xdg.configFile = {
    "wezterm/color-scheme.lua".source = ./wezterm/${flavor}.lua;
    "qtile/my_modules/colorset.py".source = ./qtile/${flavor}.py;
  };
}
