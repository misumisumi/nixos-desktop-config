{
  pkgs,
  lib,
  config,
  scheme ? "small",
  ...
}:
let
  flavor = "tokyonight_storm";
  pack = pkgs.callPackage ./pack.nix { };
in
{
  programs = {
    alacritty.settings = lib.importTOML "${pack}/alacritty/${flavor}.toml";
    starship.settings = lib.importTOML ./starship/tokyonight.toml;
    kitty.themeFile = "${builtins.replaceStrings [ "tokyonight" ] [ "tokyo_night" ] flavor}";
    yazi.theme = lib.importTOML "${pack}/yazi/${flavor}.toml";
    bat = {
      config.theme = flavor;
      themes.${flavor} = {
        src = pack;
        file = "bat/${flavor}.tmTheme";
      };
    };
    git = {
      includes = [ { path = "${pack}/delta/${flavor}.gitconfig"; } ];
      delta.options.features = "${flavor}";
    };
    zathura.extraConfig = ''
      include ${pack + "/zatura/${flavor}.zathurarc"}
    '';
  };
}
// lib.optionals (scheme != "core") {
  home.sessionVariables = {
    LG_CONFIG_FILE =
      let
        enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;
        configDirectory =
          if enableXdgConfig then
            config.xdg.configHome
          else
            "${config.home.homeDirectory}/Library/Application Support";
        configFile = "${configDirectory}/lazygit/config.yml";
      in
      "${pack}/lazygit/${flavor}.yml,${configFile}";
  };
}
// lib.optionals (scheme == "full") {
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-tokyonight ];
  xdg.configFile = {
    "wezterm/color-scheme.lua".source = ./wezterm/color-scheme.lua;
    "qtile/my_modules/colorset.py".source = ./qtile/colorset.py;
    "dunst/dunstrc.d/00-${flavor}.dunstrc".source = "${pack}/themes/dunst/${flavor}.dunstrc";
    "yazi/${flavor}.tmTheme".source = "${pack}/bat/${flavor}.tmTheme";
  };
  gtk.theme = {
    name = "Tokyonight-Dark";
    package = pkgs.tokyonight-gtk-theme;
  };
  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
  };
}
