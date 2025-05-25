{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./alacritty.nix
    ./dunstrc.nix
    ./kitty.nix
    ./rofi.nix
    ./lazygit.nix
    ./zathura.nix
  ];
  programs = {
    starship.settings = lib.importTOML ./starship/nord.toml;
    yazi.theme = lib.importTOML ./yazi/nord.toml;
    bat.config.theme = "nord";
    btop.settings.color_theme = "nord";
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        theme = spicePkgs.themes.nord;
        colorScheme = "Nord";
      };
  };
  xdg.configFile = {
    "fcitx5/conf/classicui.conf" = {
      enable = config.i18n.inputMethod.enabled == "fcitx5";
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          Theme = "Nord-Dark";
          DarkTHeme = "Nord-Dark";
          UseDarkTheme = "True"; # Follow system light/dark color scheme
        };
      };
    };
    "bat/Nord.tmTheme" = {
      inherit (config.programs.bat) enable;
      source = ./sublime/Nord.tmTheme;
    };
    "qtile/my_modules/colorset.py" = {
      inherit (config.xsession.windowManager.qtile) enable;
      source = ./qtile/nord.py;
    };
    "wezterm/color-scheme.lua" = {
      inherit (config.programs.wezterm) enable;
      source = ./wezterm/nord.lua;
    };
    "yazi/Nord.tmTheme" = {
      inherit (config.programs.yazi) enable;
      source = ./sublime/Nord.tmTheme;
    };
  };
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-nord ];
  gtk = {
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy-dark";
      package = pkgs.nordzy-icon-theme;
    };
  };
  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
  };
}
