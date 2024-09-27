{
  lib,
  pkgs,
  scheme,
  ...
}:
{
  imports =
    [
      ./lazygit.nix
      ./zathura.nix
    ]
    // lib.optionals (scheme == "full") [
      ./alacritty.nix
      ./kitty.nix
    ];
  programs.starship.settings = {
    starship.settings = lib.importTOML ./starship/nord.toml;
    yazi.theme = lib.importTOML ./yazi/nord.toml;
    bat = {
      config.theme = "nord";
      themes.nord = lib.readFile ./sublime/Nord.tmTheme;
    };
    btop.settings = {
      color_theme = "nord";
    };
  };
  xdg.configFile = {
    "yazi/Nord.tmTheme" = ./sublime/Nord.tmTheme;
  };
}
// lib.optionals (scheme == "full") {
  imports = [
    ./dunstrc.nix
  ];
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-nord ];
  xdg.configFile = {
    "fcitx5/conf/classicui.conf".text = lib.generators.toINIWithGlobalSection { } {
      globalSection = {
        Theme = "Nord-Dark";
        DarkTHeme = "Nord-Dark";
      };
    };
    "wezterm/color-scheme.lua".source = ./wezterm/nord.lua;
    "qtile/my_modules/colorset.py".source = ./qtile/nord.py;
  };
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
