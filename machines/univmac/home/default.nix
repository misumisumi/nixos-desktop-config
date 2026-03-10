{
  config,
  lib,
  pkgs,
  getEncryptFile,
  ...
}:
let
  inherit (config.lib.ndchm.chezmoi) getChezmoiFilePath;
in
{
  imports = [
    ../../../apps/user/desktop/tool/browser/firefox
    ../../../apps/user/desktop/tool/develop/zotero
    ../../../apps/user/desktop/tool/multimedia/mpv
  ];
  home = {
    activation.apply-vivaldi-config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "$HOME/Library/Application Support/Vivaldi" ]; then
        while read -r profile; do
          TMP="''${profile}/Preferences.bak"
          mv "''${profile}/Preferences" "''${TMP}"
          ${pkgs.jq}/bin/jq -r -s '.[0] * .[1]' "''${TMP}" ${getChezmoiFilePath "dot_config/vivaldi/CommonPreferences"} > "''${profile}/Preferences.new"
          if [ -s "''${profile}/Preferences.new" ]; then
            mv "''${profile}/Preferences.new" "''${profile}/Preferences"
          else
            rm "''${profile}/Preferences.new"
          fi
        done < <(find "$HOME/Library/Application Support/Vivaldi" -maxdepth 1 -type d -name "Default" -or -name "Profile *")
      fi
    '';
    packages = with pkgs; [
      # comms
      discord
      slack
      zoom-us
      # develop
      inkscape
      (google-fonts.override {
        fonts = [
          "BIZUDMincho"
          "BIZUDPMincho"
          "BIZUDGothic"
          "BIZUDPGothic"
        ];
      })
    ];
  };
  sops.secrets = {
    "env" = {
      path = "${config.home.homeDirectory}/.env";
      sopsFile = getEncryptFile "pkgs/ai-tools/env";
      format = "binary";
    };
    "desktops" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
      sopsFile = getEncryptFile "pkgs/ssh/desktops";
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = getEncryptFile "pkgs/ssh/univ";
      format = "binary";
    };
  };
}
