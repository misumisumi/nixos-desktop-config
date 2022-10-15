{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      # name = "Noto Sans CJK JP";
      # package = pkgs.noto-fonts-cjk-sans;
      # size = 12;
      name = "Source Han Sans";       # Noto Sans CJKを使うとdiscordで文字化けが起こる問題の回避 (https://github.com/NixOS/nixpkgs/issues/171976)
      package = pkgs.source-han-sans;
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adapta-Nokto-Eta";
      package = pkgs.adapta-gtk-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
