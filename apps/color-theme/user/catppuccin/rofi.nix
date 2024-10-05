{
  pkgs,
  config,
  colorTheme,
  ...
}:
let
  flavor = builtins.replaceStrings [ "catppuccin-" ] [ "" ] colorTheme;
  catppuccin-custom = pkgs.writeText "catppuccin-custom.rasi" ''
    @theme "catppuccin-${flavor}"

    * {
        font: "${config.programs.rofi.font}";
    }

    window {
        width: 30%;
        orientation: horizontal;
        location: center;
        anchor: center;
    }
    listview {
        layout: vertical;
        columns: 1;
        lines: 7;
        margin: 10px 20px 0px 20px;
    }

    element selected {
        background-color: @blue;
        text-color: @bg-col;
    }
  '';
in
{
  xdg.configFile = {
    "rofi/themes/catppuccin-${flavor}.rasi" = {
      inherit (config.programs.rofi) enable;
      source = "${pkgs.catppuccin.override { variant = "${flavor}"; }}/rofi/catppuccin-${flavor}.rasi";
    };
    "rofi/themes/catppuccin-custom.rasi" = {
      inherit (config.programs.rofi) enable;
      source = catppuccin-custom;
    };
  };
  programs.rofi.theme = "catppuccin-custom";
}
