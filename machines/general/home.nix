{ lib, hostname, config, pkgs, ... }:

{
  imports = (import ../../apps/common/cli) ++
            (import ../../apps/common/git) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell) ++
            (import ../../apps/desktop { inherit lib hostname; }) ++
            (import ../../apps/desktop/wm/${wm});

  home = {
    packages = (import ../../apps/common/pkgs) pkgs ++
               (import ../../apps/desktop/pkgs) pkgs;
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}
