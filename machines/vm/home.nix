#
# Home-manager configuration for mother
#
# flake.nix
{ pkgs, ... }:

{
  imports = (import ../../apps/common/cui) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell);

  home = {
    packages = (import ../../apps/common/extra-pkgs.nix).extra-pkgs;
  };
}
