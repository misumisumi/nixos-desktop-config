{ pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.fcitx5-gtk
          pkgs.libsForQt5.fcitx5-qt
          pkgs.fcitx5-mozc
          pkgs.fcitx5-configtool
          pkgs.nur.repos.xddxdd.fcitx5-breeze
        ];
      };
    };
  };
}
