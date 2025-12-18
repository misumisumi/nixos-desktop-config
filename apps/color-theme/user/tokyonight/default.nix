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
    kitty = {
      "${kittyAttrName}" = "tokyo_night_${flavor}";
      settings = {
        #NOTE: Dealing with the problem that if the background color of vim and kitty is the same, it is treated as transparent
        background =
          if flavor == "day" then
            "#e1e2e8"
          else if flavor == "moon" then
            "#222437"
          else if flavor == "night" then
            "#1a1b27"
          else
            "#24283c";
      };
    };
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
    zathura.extraConfig =
      let
        highlight =
          if flavor == "day" then
            {
              color = "rgba(140,108,62,0.5)";
              active = "rgba(88,117,57,0.5)";
            }
          else if flavor == "moon" then
            {
              color = "rgba(255,199,119,0.5)";
              active = "rgba(195,232,141,0.5)";
            }
          else if flavor == "night" then
            {
              color = "rgba(224,175,104,0.5)";
              active = "rgba(158,206,106,0.5)";
            }
          else
            {
              color = "rgba(224,175,104,0.5)";
              active = "rgba(158,206,106,0.5)";
            };
      in
      lib.mkBefore ''
        include ${pack + "/zathura/tokyonight_${flavor}.zathurarc"}

        set highlight-color ${highlight.color}
        set highlight-active-color ${highlight.active}
      '';
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
  home = {
    sessionVariables = {
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
  // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    pointerCursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
    };
  };
  services.dunst.settings = lib.importTOML "${pack}/dunst/tokyonight_${flavor}.dunstrc";

  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-tokyonight ];

  xdg.configFile = {
    "fcitx5/conf/classicui.conf" = {
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection =
          let
            Theme = "Tokyonight-${if flavor == "day" then "Day" else "Storm"}";
          in
          {
            inherit Theme;
            DarkTheme = Theme;
            UseDarkTheme = if flavor == "day" then "False" else "True"; # Follow system light/dark color scheme
          };
      };
    };
    "wezterm/color-scheme.lua" = {
      inherit (config.programs.wezterm) enable;
      source = ./wezterm/${flavor}.lua;
    };
    "qtile/my_modules/colorset.py" = {
      inherit (config.xsession.windowManager.qtile) enable;
      source = ./qtile/${flavor}.py;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = if flavor == "day" then "prefer-light" else "prefer-dark";
    };
  };
  gtk = {
    # gtk3.extraConfig.gtk-application-prefer-dark-theme = flavor != "day";
    theme =
      let
        shade = if flavor == "day" then "Light" else "Dark";
      in
      {
        name = "Tokyonight-${shade}";
        package = pkgs.tokyonight-gtk-theme;
      };
    gtk4.theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
  }
  // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
