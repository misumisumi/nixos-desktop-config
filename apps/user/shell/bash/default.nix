{
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
      ;
    inherit ((importChezmoiUserAppData user).shell) historyIgnore;
  };
}
