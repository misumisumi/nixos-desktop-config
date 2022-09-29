#
# Home-manager configuration for mother
#
# flake.nix

{ pkgs, ... }:
{
  imports = [
    ../../apps/desktop/wm/home.nix
  ];
  home = {
    package = with pkgs; [];
  };
}
