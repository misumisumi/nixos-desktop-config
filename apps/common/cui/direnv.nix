/*
Each dir, Each ENV
*/
{ pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };
  };
}
