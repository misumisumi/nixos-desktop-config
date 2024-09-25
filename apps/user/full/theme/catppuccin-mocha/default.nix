{ pkgs, ... }:
{
  catppuccin.pointerCursor.enable = true;
  i18n.inputMethod.fcitx5.catppuccin.enable = true;
  programs = {
    alacritty.catppuccin.enable = true;
    bat.catppuccin.enable = true;
    btop.catppuccin.enable = true;
    git.delta.catppuccin.enable = true;
    # fzf.catppuccin.enable = true;
    kitty.catppuccin.enable = true;
    obs-studio.catppuccin.enable = true;
    # rofi.catppuccin.enable = true;
    # starchip.catppuccin.enable = true;
    # tmux.catppuccin.enable = true;
    yazi.catppuccin.enable = true;
    zathura.catppuccin.enable = true;
  };
  services = {
    dunst.catppuccin.enable = true;
  };
  gtk.theme = {
    name = "Catppuccin-GTK-Dark";
    package = pkgs.magnetic-catppuccin-gtk;
  };
}
