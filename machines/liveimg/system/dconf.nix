{ lib, ... }:
let
  inherit (lib.gvariant) mkTuple mkUint32;
in
{
  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            # dark mode
            "org/gnome/desktop/interface".color-scheme = "prefer-dark";
            # disable suspend when connected ac
            "org/gnome/settings-daemon/plugins/power" = {
              sleep-inactive-ac-timeout = mkUint32 1800;
              sleep-inactive-ac-type = "nothing";
              sleep-inactive-battery-timeout = mkUint32 1800;
              sleep-inactive-battery-type = "suspend";
            };
            "org/gnome/desktop/input-sources" = {
              sources = [
                # ご利用の物理キーボード配列に合わせて "us" または "jp" を指定します
                (mkTuple [
                  "xkb"
                  "jp"
                ])
              ];
            };
            "org/gnome/desktop/session" = {
              # 画面がブランクになるまでの時間を秒で指定 (例: 300 = 5分)
              # 0 を指定すると「しない (Never)」になります
              idle-delay = mkUint32 0;
            };
            # アイドル時に画面が暗くなる（Dim Screen）設定
            "org/gnome/settings-daemon/plugins/power" = {
              idle-dim = false; # falseで無効化
            };
          };
        }
      ];
    };
  };
}
