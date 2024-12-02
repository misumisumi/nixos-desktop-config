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
          width: 40%;
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
    "rofi/themes/catppuccin-macchiato.rasi" = {
      inherit (config.programs.rofi) enable;
      source = "${pkgs.catppuccin}/rofi/catppuccin-macchiato.rasi";
    };
    "rofi/themes/nord.rasi" = {
      inherit (config.programs.rofi) enable;
      source = nord-rasi;
    };
  };
  programs.rofi.theme = "nord";
}
