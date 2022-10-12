#
# Home-manager configuration for mother
#
# flake.nix
{ config, pkgs, ... }:

{
  imports = (import ../../apps/common/cui) ++
            (import ../../apps/common/git) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell) ++
            (import ../../apps/desktop);

  home = {
    packages = (import ../../apps/common/pkgs) pkgs ++
               (import ../../apps/desktop/pkgs) pkgs;
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}