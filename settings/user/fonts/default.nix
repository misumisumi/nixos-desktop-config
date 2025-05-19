{ pkgs, ... }:
{
  home.packages = with pkgs; [
    noto-fonts-emoji
    # noto-fonts # Normal usage
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    papirus-icon-theme # Icons
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Noto Sans Mono CJK JP" ];
      sansSerif = [ "Noto Sans CJK JP" ];
      serif = [ "Noto Serif CJK JP" ];
    };
  };
}
