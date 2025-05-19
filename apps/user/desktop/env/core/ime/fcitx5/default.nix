# Fcitx5 (IME) conf
{ pkgs, ... }:
{
  xdg.configFile = {
    "fcitx5/profile".source = ./conf/profile;
    "fcitx5/conf/classicui.conf".source = ./conf/classicui.conf;
    "fcitx5/conf/xim.conf".source = ./conf/xim.conf;
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-mozc
      fcitx5-configtool
    ];
  };
}
