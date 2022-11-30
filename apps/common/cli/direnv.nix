/*
Each dir, Each ENV
*/
{ pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv = {
        enable = true;
      };
    };
  };
}
