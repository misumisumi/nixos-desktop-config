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
    ++ lib.optionals (scheme == "full") [
      ./alacritty.nix
      ./dunstrc.nix
      ./kitty.nix
      ./rofi.nix
    ];
  programs = {
    starship.settings = lib.importTOML ./starship/nord.toml;
    yazi.theme = lib.importTOML ./yazi/nord.toml;
    bat.config.theme = "nord";
    btop.settings.color_theme = "nord";
  };
  xdg.configFile =
    {
      "bat/Nord.tmTheme".source = ./sublime/Nord.tmTheme;
      "yazi/Nord.tmTheme".source = ./sublime/Nord.tmTheme;
    }
    // lib.optionalAttrs (scheme == "full") {
      "fcitx5/conf/classicui.conf".text = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          Theme = "Nord-Dark";
          DarkTHeme = "Nord-Dark";
        };
      };
      "wezterm/color-scheme.lua".source = ./wezterm/nord.lua;
      "qtile/my_modules/colorset.py".source = ./qtile/nord.py;
    };
}
// lib.optionalAttrs (scheme == "full") {
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
