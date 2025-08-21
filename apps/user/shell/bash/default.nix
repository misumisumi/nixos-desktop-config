{
  lib,
  user,
  importChezmoiUserAppData,
  config,
  ...
}:
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
    historyIgnore =
      map (x: lib.removeSuffix " *" x)
        (importChezmoiUserAppData user).shell.historyIgnore;
  };
}
