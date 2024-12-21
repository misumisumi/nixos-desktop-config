{
  lib,
  pkgs,
  chezmoiToNix,
  ...
}:
with lib;
{
  home.packages = with pkgs; [
    git-ignore
    git-secret
    github-cli
  ];
  programs = {
    git = {
      enable = true;
      userEmail = "dragon511southern@gmail.com";
      userName = "misumisumi";
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
  };

  xdg.configFile = chezmoiToNix {
    chezmoiSrc = "dot_config/git";
    recursive = true;
  };
}
