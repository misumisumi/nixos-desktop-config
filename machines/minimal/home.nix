{ lib, hostname, config, pkgs, ... }:

{
  imports = (import ../../apps/common/git) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell);
}
