{
  services.yaskkserv2.enable = true;
  xdg = {
    configFile = {
      "libskk/rules/user-config".source = ./skk-config/libskk;
      "fcitx5/conf/skk.conf".source = ./skk-config/fcitx5/skk.conf;
    };
  };
  home.file.".dual-function-keys.yaml".text = ''
    MAPPINGS:
      - KEY: KEY_SPACE
        TAP: KEY_SPACE
        HOLD: KEY_LEFTSHIFT
        HOLD_START: BEFORE_CONSUME_OR_RELEASE
  '';
}
