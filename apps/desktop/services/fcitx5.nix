# Fcitx5 (IME) conf
{ pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          libsForQt5.fcitx5-qt
          fcitx5-mozc
          fcitx5-configtool
          fcitx5-nord
        ];
      };
    };
  };
}
