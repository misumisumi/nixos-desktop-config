{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        # serif = [ "Source Han Serif" ];
        # sansSerif = [ "Source Han Sans" ];
        # monospace = [ "Source Han Mono" ];
        serif = [ "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans CJK JP" ];
        monospace = [ "Noto Sans Mono CJK JP" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts # Normal usage
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      # source-han-sans
      # source-han-serif
      # source-han-mono

      papirus-icon-theme # Icons
    ];
  };
}
