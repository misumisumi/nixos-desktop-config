{
  services.yaskkserv2.enable = true;
  xdg = {
    configFile = {
      "libskk/rules/user-config".source = ./skk-config/libskk;
      "fcitx5/conf/skk.conf".source = ./skk-config/fcitx5/skk.conf;
    };
  };
}
