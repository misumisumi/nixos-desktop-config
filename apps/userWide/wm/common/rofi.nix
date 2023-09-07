/*
  Rofi (App launcher) conf
*/
{ pkgs, ... }:
let
  iggy_conf = ''
    @theme "iggy"
    button-iggy1, button-iggy2 {
      content: "";
    }
    window {
        border:           0;
        padding:          5;
        width: 1024px;
        background-image: url("${pkgs.my-wallpapers}/wallpapers/background.png", width);
    }
    button-iggy1, button-iggy2 {
      content: "";
    }
    listview, inputbar, message {
      border-color: cyan;
    }
    element-icon {
        size: 2.5em;
    }
    element  selected {
      border-color: cyan;
      background-color: cyan/20%;
    }
    icon-ms-ic1,icon-ms-ic2 {
      border-color: cyan;
    }
    button {
      border-color: cyan;
      background-image: linear-gradient(to bottom, cyan/50%, black/70%);
    }
    button selected.normal {
      background-image: linear-gradient(to bottom, darkcyan, black/70%);
      border-color: cyan;
    }
  '';

  adapta = ''
    @theme "Adapta-Nokto"

    window {
        border:           0;
        padding:          5;
    }
    element-icon {
        size: 0.8em;
    }
  '';
in
{
  xdg = {
    configFile = {
      "rofi/my_theme.rasi".text = adapta;
    };
  };
  home.packages = with pkgs; [ rofi-power-menu ];

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-calc
      ];

      font = "UDEV Gothic 35LG 20";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = "my_theme.rasi";

      extraConfig = {
        lines = 12;
        modi = "window,run,ssh,drun";
        show-icons = true;
        icon-theme = "Papirus-Dark";
        drun-show-actions = false;
        kb-remove-char-back = "BackSpace,Shift+BackSpace,Control+q";
        kb-remove-to-eol = "Control+D";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-mode-complete = "Control+c";
        kb-row-left = "Control+Page_Up,Control+h";
        kb-row-right = "Control+l";
        kb-row-up = "Up,Control+p,Control+k";
        kb-row-down = "Down,Control+n,Control+j";
      };
    };
  };
}
