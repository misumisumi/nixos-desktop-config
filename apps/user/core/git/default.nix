{
  lib,
  pkgs,
  user,
  importFilesFromChezmoi,
  importChezmoiUserAppData,
  ...
}:
with lib;
{
  home.packages = with pkgs; [
    git-ignore
    git-secret
    github-cli
  ];
  programs.git =
    let
      inherit (importChezmoiUserAppData "${user}") git;
    in
    {
      enable = true;
      inherit (git) userEmail userName aliases;
      signing = {
        inherit (git.signing) key format signByDefault;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        commit = {
          template = "~/.config/git/message";
        };
      };
      delta.enable = true;
      lfs.enable = true;
    };

  xdg.configFile = importFilesFromChezmoi {
    chezmoiSrc = "dot_config/git";
    recursive = true;
  };
}
