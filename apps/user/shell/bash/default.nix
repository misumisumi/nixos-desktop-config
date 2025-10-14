{
  lib,
  user,
  config,
  ...
}:
let
  inherit (lib) removeSuffix;
  inherit (config.lib.ndchm.chezmoi) importChezmoiUserAppData;
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "ignoreboth" ];
    historyFile = "${config.xdg.dataHome}/bash/history";
    inherit ((importChezmoiUserAppData user).bash)
      bashrcExtra
      initExtra
      logoutExtra
      profileExtra
      shellOptions
      ;
    historyIgnore = map (x: removeSuffix " *" x) (importChezmoiUserAppData user).shell.historyIgnore;
  };
}
