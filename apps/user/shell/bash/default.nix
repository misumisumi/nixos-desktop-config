{
  user,
  importChezmoiUserAppData,
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "ignoreboth" ];
    inherit ((importChezmoiUserAppData user).bash)
      bashrcExtra
      initExtra
      logoutExtra
      profileExtra
      ;
    inherit ((importChezmoiUserAppData user).shell) historyIgnore;
  };
}
