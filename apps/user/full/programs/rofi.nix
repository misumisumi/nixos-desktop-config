{ pkgs, ... }:
{
  home.packages = with pkgs; [ rofi-power-menu ];

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];

      font = "Moralerspace Neon NF 14";
      terminal = "wezterm";

      extraConfig = {
        modi = "window,drun,run";
        combi-modi = "window,drun";
        show-icons = true;
        icon-theme = "Papirus-Dark";
        drun-show-actions = false;
        drun-display-format = "{icon} {name}";
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = "   Window";
        location = 0;
        disable-history = false;
        sidebar-mode = false;

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
