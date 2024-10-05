{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi-power-menu
    rofimoji
  ];

  xdg.configFile."rofimoji.rc".text = ''
    action = copy
    files = [emojis, kaomoji]
    skin-tone = moderate
  '';

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [ rofi-calc ];

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
        sidebar-mode = true;
        # Keybindings
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-mode-complete = "Control+c";
        kb-remove-char-back = "BackSpace,Shift+BackSpace,Control+q";
        kb-remove-to-eol = "Control+D";
        kb-row-down = "Down,Control+n,Control+j";
        kb-row-left = "Control+Page_Up,Control+h";
        kb-row-right = "Control+l";
        kb-row-up = "Up,Control+p,Control+k";
      };
    };
  };
}
