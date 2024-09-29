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
  rofi-catppuccin = pkgs.stdenvNoCC.mkDerivation {
    name = "rofi-catppuccin";
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      find ${
        pkgs.catppuccin.override { variant = "${flavor}"; }
      } -name '*.rasi' -exec cp {} $out/share/rofi/themes/ \;
      cp ${catppuccin-custom} $out/share/rofi/themes/catppuccin-custom.rasi
    '';
  };
in
{
  xdg.configFile."rofi/themes/catppuccin-custom.rasi".source = catppuccin-custom;
  programs.rofi.theme = "catppuccin-custom";
}
