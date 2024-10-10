{
  pkgs,
  lib,
  inputs,
  config,
  colorTheme ? "catppuccin-macchiato",
  ...
}:
let
  flavor = builtins.replaceStrings [ "catppuccin-" ] [ "" ] colorTheme;
in
{
  imports = [
    ./rofi.nix
  ];
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
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "${flavor}";
      };
  };
  services = {
    dunst.catppuccin.enable = true;
  };
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-catppuccin ];
  gtk = {
    theme =
      let
        shade = if flavor == "latte" then "Light" else "Dark";
      in
      {
        name = "Catppuccin-GTK-${shade}";
        package = pkgs.magnetic-catppuccin-gtk.override { shade = lib.toLower shade; };
      };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  xdg.configFile = {
    "wezterm/color-scheme.lua" = {
      inherit (config.programs.wezterm) enable;
      source = ./wezterm/${flavor}.lua;
    };
    "qtile/my_modules/colorset.py" = {
      inherit (config.xsession.windowManager.qtile) enable;
      source = ./qtile/${flavor}.py;
    };
    "fcitx5/conf/classicui.conf" = {
      enable = config.i18n.inputMethod.enabled == "fcitx5";
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          Theme = "catppuccin-${flavor}-blue";
          DarkTHeme = "catppuccin-${flavor}-blue";
        };
      };
    };
  };
}
