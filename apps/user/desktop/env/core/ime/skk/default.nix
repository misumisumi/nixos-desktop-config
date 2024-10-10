{ pkgs, ... }:
{
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-skk
  ];
  xdg.configFile = {
    "libskk/rules/user-config" = {
      source = ./libskk;
      recursive = true;
    };
    "fcitx5/conf/skk.conf".source = ./fcitx5/skk.conf;
  };
  home.file = {
    # Auto update skk dict
    ".local/share/fcitx5/skk/dictionary_list".text = ''
      file=$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite,type=file
      encoding=UTF-8,host=localhost,port=1178,type=server
    '';
  };
}
