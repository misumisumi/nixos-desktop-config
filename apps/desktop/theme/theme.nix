{ pkgs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Breeze-Adapta-Cursor";
      package = pkgs.capitaine-cursors;
      size=0;    # Use default size
    };
    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
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
