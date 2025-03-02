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
    * {
        font: "${config.programs.rofi.font}";
        ${palette.${flavor}}
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
    "rofi/themes/${colorTheme}.rasi" = {
      inherit (config.programs.rofi) enable;
      source = tokyonight-rasi;
    };
  };
  programs.rofi.theme = "${colorTheme}";
}
