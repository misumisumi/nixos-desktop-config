{ pkgs, ... }:
let
  catppuccin-custom = pkgs.writeText "catppuccin-custom.rasi" ''
    @theme "catppuccin-mocha"

    * {
        width: 30%;
    }
    window {
        height: 30%;
    }
    listview {
        padding: 15px 0px 0px 0px;
        columns: 1;
        lines: 8;
    }
    element selected {
        background-color: @blue;
        text-color: @bg-col;
    }
  '';
  rofi-catppuccin = pkgs.stdenvNoCC.mkDerivation {
    name = "rofi-catppuccin";
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      find ${
        pkgs.catppuccin.override { variant = "mocha"; }
      } -name '*.rasi' -exec cp {} $out/share/rofi/themes/ \;
      cp ${catppuccin-custom} $out/share/rofi/themes/catppuccin-custom.rasi
    '';
  };
in
{
  home.packages = with pkgs; [ rofi-power-menu ];

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
        rofi-catppuccin
      ];

      font = "Moralerspace Neon NF 20";
      terminal = "wezterm";
      theme = "catppuccin-custom";

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
