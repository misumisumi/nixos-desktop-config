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

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        width: 40%;
        height: 360px;
        border: 3px;
        border-color: @base;
        background-color: @base;
        orientation: horizontal;
        location: center;
        anchor: center;
    }

    mainbox {
        background-color: @base;
    }

    inputbar {
        children: [prompt,entry];
        background-color: @base;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @blue;
        padding: 6px;
        text-color: @base;
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
        text-color: @text;
        background-color: @base;
    }

    listview {
        layout: vertical;
        border: 0px 0px 0px;
        padding: 6px 0px 0px;
        margin: 10px 20px 0px 20px;
        columns: 1;
        lines: 7;
        background-color: @base;
    }

    element {
        padding: 5px;
        background-color: @base;
        text-color: @overlay0  ;
    }

    element-icon {
        size: 25px;
    }

    element selected {
        background-color: @blue;
        text-color: @base;
    }

    mode-switcher {
        spacing: 0;
      }

    button {
        padding: 10px;
        background-color: @base;
        text-color: @overlay0;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color: @base;
      text-color: @blue;
    }

    message {
        background-color: @base;
        margin: 2px;
        padding: 2px;
        border-radius: 5px;
    }

    textbox {
        padding: 6px;
        margin: 20px 0px 0px 20px;
        text-color: @blue;
        background-color: @base;
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
