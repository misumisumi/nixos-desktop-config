#
# Home-manager configuration for mother
#
# flake.nix
{ pkgs, stateVersion, ... }:

{
  imports = (import ../../apps/common/cui) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell);

  home = {
    stateVersion = stateVersion;
    packages = with pkgs; (import ../../apps/common/extra-pkgs.nix);
  };
}
