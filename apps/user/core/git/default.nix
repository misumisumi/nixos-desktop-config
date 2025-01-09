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
      userEmail = "sumiharu@misumi-sumi.com";
      userName = "misumisumi";
      signing.key = "F9C2261B92168D38";
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
