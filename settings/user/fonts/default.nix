{ pkgs, lib, ... }:
{
  home.packages =
    with pkgs;
    [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
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
