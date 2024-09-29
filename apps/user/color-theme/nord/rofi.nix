{ pkgs, config, ... }:
let
  nord-rasi = pkgs.writeText "nord.rasi" ''
    @theme "catppuccin-macchiato"

    * {
        font: "${config.programs.rofi.font}";
        bg-col:  #2e3440;
        bg-col-light: #2e3440;
        border-col: #2e3440;
        selected-col: #2e3440;
        blue: #81a1c1;
        fg-col: #d8dee9;
        fg-col2: #bf616a;
        grey: #4c566a;
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
  rofi-nord = pkgs.stdenvNoCC.mkDerivation {
    name = "rofi-catppuccin";
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      find ${pkgs.catppuccin} -name '*.rasi' -exec cp {} $out/share/rofi/themes/ \;
      cp ${nord-rasi} $out/share/rofi/themes/nord.rasi
    '';
  };
in
{
  xdg.configFile."rofi/themes" = {
    "catppuccin-macchiato".source = "${pkgs.catppuccin}/rofi/catppuccin-macchiato.rasi";
    "nord.rasi".source = nord-rasi;
  };
  programs.rofi.theme = "nord";
}
