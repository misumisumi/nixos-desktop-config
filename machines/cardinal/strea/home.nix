{ lib, hostname, pkgs, ... }:

{
  imports = (import ../../apps/common/cli) ++
    (import ../../apps/common/git) ++
    (import ../../apps/common/neovim) ++
    (import ../../apps/common/shell);

  home = {
    packages = (import ../../apps/common/pkgs) pkgs;
  };

}
