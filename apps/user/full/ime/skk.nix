{ pkgs, ... }:
let
  useDict = "Combined";
  dicts = {
    "Minimal" = "SKK-JISYO.S";
    "Middle" = "SKK-JISYO.M";
    "Large" = "SKK-JISYO.L";
    "Combined" = "SKK-JISYO.combined";
  };
in
{
  services.yaskkserv2.enable = true;
  xdg = {
    configFile = {
      "libskk/rules/user-config".source = ./skk-config/libskk;
      "fcitx5/conf/skk.conf".source = ./skk-config/fcitx5/skk.conf;
    };
  };
  home.file = {
    ".dual-function-keys.yaml".text = ''
      MAPPINGS:
        - KEY: KEY_SPACE
          TAP: KEY_SPACE
          HOLD: KEY_LEFTSHIFT
          HOLD_START: BEFORE_CONSUME_OR_RELEASE
    '';
    # Auto update skk dict
    ".local/share/fcitx5/skk/dictionary_list".text = ''
      file=$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite,type=file
      encoding=UTF-8,file=${pkgs.skk-emoji-jisyo}/share/SKK-JISYO.emoji.utf8,mode=readonly,type=file
      file=${pkgs.skk-dicts}/share/${dicts.${useDict}},mode=readonly,type=file
      encoding=UTF-8,host=localhost,port=1178,type=server
    '';
  };
}
