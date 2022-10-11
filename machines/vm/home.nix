#
# Home-manager configuration for mother
#
# flake.nix
{ config, pkgs, ... }:

{
  imports = (import ../../apps/common/cui) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell) ++
            (import ../../apps/desktop);

  home = {
    packages = (import ../../apps/common/extra-pkgs.nix) pkgs ++
               (import ../../apps/desktop/extra-pkgs.nix) pkgs;
  };

  xresources = {
    extraConfig = "Xft.dpi:88";
  };

}
