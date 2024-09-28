{
  pkgs,
  config,
  colorTheme,
  ...
}:
let
  flavor = builtins.replaceStrings [ "tokyonight-" ] [ "" ] colorTheme;

  palette = {
    day = ''
      bg-col:  #e1e2e7;
      bg-col-light: #e1e2e7;
      border-col: #e1e2e7;
      selected-col: #e1e2e7;
      blue: #2e7de9;
      fg-col: #3760bf;
      fg-col2: #f52a65;
      grey: #6172b0;
    '';
    moon = ''
      bg-col:  #222436;
      bg-col-light: #222436;
      border-col: #222436;
      selected-col: #222436;
      blue: #82aaff;
      fg-col: #c8d3f5;
      fg-col2: #ff757f;
      grey: #828bb8;
    '';
    night = ''
      bg-col:  #1a1b26;
      bg-col-light: #1a1b26;
      border-col: #1a1b26;
      selected-col: #1a1b26;
      blue: #7aa2f7;
      fg-col: #c0caf5;
      fg-col2: #f7768e;
      grey: #a9b1d6;
    '';
    storm = ''
      bg-col:  #24283b;
      bg-col-light: #24283b;
      border-col: #24283b;
      selected-col: #24283b;
      blue: #7aa2f7;
      fg-col: #c0caf5;
      fg-col2: #f7768e;
      grey: #a9b1d6;
    '';

  };

  tokyonight-rasi = pkgs.writeText "tokyonight.rasi" ''
    @theme "catppuccin-macchiato"

    * {
        font: "${config.programs.rofi.font}";
        ${palette.${flavor}}
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
  rofi-tokyonight = pkgs.stdenvNoCC.mkDerivation {
    name = "rofi-tokyonight";
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      find ${pkgs.catppuccin} -name '*.rasi' -exec cp {} $out/share/rofi/themes/ \;
      cp ${tokyonight-rasi} $out/share/rofi/themes/tokyonight.rasi
    '';
  };
in
{
  programs.rofi = {
    plugins = [ rofi-tokyonight ];
    theme = "tokyonight";
  };
}
