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
    packages = with pkgs; (import ../../apps/common/extra-pkgs.nix);
  };
}
