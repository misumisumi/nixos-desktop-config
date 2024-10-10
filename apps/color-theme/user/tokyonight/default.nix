{
  pkgs,
  lib,
  config,
  inputs,
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
  imports = [ ./rofi.nix ];
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
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
        fixedFlavor = {
          day = "latte";
          storm = "frappe";
          moon = "macchiato";
          night = "mocha";
        };
      in
      {
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "${fixedFlavor.${flavor}}";
      };
  };
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
  services.dunst.settings = lib.importTOML "${pack}/dunst/tokyonight_${flavor}.dunstrc";

  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-tokyonight ];

  xdg.configFile = {
    "wezterm/color-scheme.lua" = {
      inherit (config.programs.wezterm) enable;
      source = ./wezterm/${flavor}.lua;
    };
    "fcitx5/conf/classicui.conf" = {
      enable = config.i18n.inputMethod.enabled == "fcitx5";
      text =
        let
          shade = if flavor == "day" then "Day" else "Storm";
        in
        lib.generators.toINIWithGlobalSection { } {
          globalSection = {
            Theme = "Tokyonight-${shade}";
            DarkTHeme = "Tokyonight-${shade}";
          };
        };
    };
    "qtile/my_modules/colorset.py" = {
      inherit (config.xsession.windowManager.qtile) enable;
      source = ./qtile/${flavor}.py;
    };
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
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
  };
}
