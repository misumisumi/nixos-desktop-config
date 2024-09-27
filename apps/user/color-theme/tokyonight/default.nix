{
  pkgs,
  lib,
  config,
  scheme ? "small",
  colorTheme ? "tokyonight-storm",
  ...
}:
let
  flavor = builtins.replaceStrings [ "tokyonight-" ] [ "" ] colorTheme;
  pack = pkgs.callPackage ./pack.nix { };
  kittyAttrName =
    if (lib.versionAtLeast config.home.version.release "24.11") then "themeFile" else "theme";
in
{
  programs = {
    alacritty.settings = lib.importTOML "${pack}/alacritty/tokyonight_${flavor}.toml";
    starship.settings = lib.importTOML ./starship/${flavor}.toml;
    kitty."${kittyAttrName}" = "tokyo_night_${flavor}";
    yazi.theme = lib.importTOML "${pack}/yazi/tokyonight_${flavor}.toml" // {
      manager.syntect_theme = "${pack}/sublime/tokyonight_${flavor}.tmTheme";
    };
    bat = {
      config.theme = flavor;
      themes.${flavor} = {
        src = pack;
        file = "sublime/tokyonight_${flavor}.tmTheme";
      };
    };
    btop.settings = {
      color_theme = "tokyo-night";
    };
    git.includes = [ { path = "${pack}/delta/tokyonight_${flavor}.gitconfig"; } ];
    zathura.extraConfig = ''
      include ${pack + "/zatura/tokyonight_${flavor}.zathurarc"}
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
      "${pack}/lazygit/tokyonight_${flavor}.yml,${configFile}";
  };
}
// lib.optionals (scheme == "full") {
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-tokyonight ];
  xdg.configFile =
    let
      shade = if flavor == "day" then "Day" else "Storm";
    in
    {
      "fcitx5/conf/classicui.conf".text = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          Theme = "Tokyonight-${shade}";
          DarkTHeme = "Tokyonight-${shade}";
        };
      };
      "wezterm/color-scheme.lua".source = ./wezterm/${flavor}.lua;
      "qtile/my_modules/colorset.py".source = ./qtile/${flavor}.py;
      "dunst/dunstrc.d/00-${flavor}.dunstrc".source = "${pack}/themes/dunst/tokyonight_${flavor}.dunstrc";
    };
  gtk = {
    theme =
      let
        shade = if flavor == "day" then "Light" else "Dark";
      in
      {
        name = "Tokyonight-${shade}";
        package = pkgs.tokyonight-gtk-theme;
      };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };
  };
  # home.pointerCursor = {
  #   name = "Dracula-cursors";
  #   package = pkgs.dracula-theme;
  # };
}
