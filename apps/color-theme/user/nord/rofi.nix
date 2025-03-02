{ pkgs, config, ... }:
let
  nord-rasi = pkgs.writeText "nord.rasi" ''
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

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        width: 40%;
        height: 360px;
        border: 3px;
        border-color: @border-col;
        background-color: @bg-col;
        orientation: horizontal;
        location: center;
        anchor: center;
    }

    mainbox {
        background-color: @bg-col;
    }

    inputbar {
        children: [prompt,entry];
        background-color: @bg-col;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @blue;
        padding: 6px;
        text-color: @bg-col;
        border-radius: 3px;
        margin: 20px 0px 0px 20px;
    }

    textbox-prompt-colon {
        expand: false;
        str: ":";
    }

    entry {
        padding: 6px;
        margin: 20px 0px 0px 10px;
        text-color: @fg-col;
        background-color: @bg-col;
    }

    listview {
        layout: vertical;
        border: 0px 0px 0px;
        padding: 6px 0px 0px;
        margin: 10px 20px 0px 20px;
        columns: 1;
        lines: 7;
        background-color: @bg-col;
    }

    element {
        padding: 5px;
        background-color: @bg-col;
        text-color: @fg-col  ;
    }

    element-icon {
        size: 25px;
    }

    element selected {
        background-color: @blue;
        text-color: @bg-col;
    }

    mode-switcher {
        spacing: 0;
      }

    button {
        padding: 10px;
        background-color: @bg-col-light;
        text-color: @grey;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color: @bg-col;
      text-color: @blue;
    }

    message {
        background-color: @bg-col-light;
        margin: 2px;
        padding: 2px;
        border-radius: 5px;
    }

    textbox {
        padding: 6px;
        margin: 20px 0px 0px 20px;
        text-color: @blue;
        background-color: @bg-col-light;
    }
  '';
in
{
  xdg.configFile = {
    "rofi/themes/nord.rasi" = {
      inherit (config.programs.rofi) enable;
      source = nord-rasi;
    };
  };
  programs.rofi.theme = "nord";
}
