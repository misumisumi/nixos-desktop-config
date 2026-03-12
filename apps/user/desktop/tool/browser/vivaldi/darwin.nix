{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.lib.ndchm.chezmoi) getChezmoiFilePath;
in
{
  home.activation.apply-vivaldi-config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    find "$HOME/Library/Application Support/Vivaldi" -maxdepth 1 -type d -name "Default" -or -name "Profile *" | while read -r profile; do
      TMP="''${profile}/Preferences.bak"
      mv "''${profile}/Preferences" "''${TMP}"
      ${pkgs.jq}/bin/jq -r -s '.[0] * .[1]' "''${TMP}" ${getChezmoiFilePath "dot_config/vivaldi/CommonPreferences"} > "''${profile}/Preferences.new"
      if [ -s "''${profile}/Preferences.new" ]; then
        mv "''${profile}/Preferences.new" "''${profile}/Preferences"
      else
        rm "''${profile}/Preferences.new"
      fi
    done
  '';
}
