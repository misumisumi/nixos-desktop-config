/*
Rofi (App launcher) conf
*/
{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "rofi/my_theme.rasi".text = ''
        @theme "Adapta-Nokto"

        window {
            border:           0;
            padding:          5;
        }
        element-icon {
            size: 1.65ch;
        }
      '';
    };
  };
  home.packages = with pkgs; [ rofi-power-menu ];

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [
                             rofi-calc
                           ];

      font = "Ricty Diminished with Fira Code 24";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = "my_theme.rasi";

      extraConfig = {
        modi = "window,run,ssh,drun";
        show-icons = true;
        icon-theme = "Papirus-Dark";
        drun-show-actions = false;
        kb-remove-char-back = "BackSpace,Shift+BackSpace,Control+q";
        kb-remove-to-eol = "Control+p";
        kb-accept-entry = "Control+n,Control+m,Return,KP_Enter";
        kb-mode-complete = "Control+c";
        kb-row-left = "Control+Page_Up,Control+h";
        kb-row-right = "Control+l";
        kb-row-up = "Up,Control+k";
        kb-row-down = "Down,Control+j";
      };
    };
  };
}
