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
  shade = if flavor == "latte" then "Light" else "Dark";
in
{
  imports = [
    ./rofi.nix
  ];
  catppuccin = {
    inherit flavor;
    cursors.enable = true;
    alacritty.enable = true;
    bat.enable = true;
    btop.enable = true;
    dunst.enable = true;
    delta.enable = true;
    kitty.enable = true;
    obs.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zathura.enable = true;
  };
  programs = {
    starship.settings = {
      palettes."catppuccin_${flavor}" =
        let
          palette =
            (lib.importTOML "${config.catppuccin.sources.starship}/${flavor}.toml")
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
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "${flavor}";
      };
  };
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-catppuccin ];
  qt.style.name = "adwaita-${lib.toLower shade}";
  gtk = {
    colorScheme = lib.toLower shade;
    theme = {
      name = "Catppuccin-GTK-${shade}";
      package = pkgs.magnetic-catppuccin-gtk.override { shade = lib.toLower shade; };
    };
    gtk4 = {
      theme =
        let
          shade = if flavor == "latte" then "Light" else "Dark";
        in
        {
          name = "Catppuccin-GTK-${shade}";
          package = pkgs.magnetic-catppuccin-gtk.override { shade = lib.toLower shade; };
        };
    };
  }
  // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
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
          Theme = "catppuccin-${flavor}-pink";
          DarkTHeme = "catppuccin-${flavor}-pink";
          UseDarkTheme = if flavor == "latte" then "False" else "True"; # Follow system light/dark color scheme
        };
      };
    };
  }
  // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    # NOTE: https://forum.endeavouros.com/t/getting-kdeconnect-to-use-kvantum-theme-outside-of-plasma/57717
    "kdeglobals".source = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
  };
}
