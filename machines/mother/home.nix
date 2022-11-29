{ lib, hostname, pkgs, ... }:

{
  imports = (import ../../apps/common/cli) ++
            (import ../../apps/common/git) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell) ++
            (import ../../apps/desktop { inherit lib hostname; }) ++
            (import ../../apps/desktop/wm/qtile);

  home = {
    packages = (import ../../apps/common/pkgs) pkgs ++
               (import ../../apps/desktop/pkgs) pkgs ++
               (import ../../apps/virtualisation/pkgs) pkgs ++
               (import ./pkg.nix) pkgs;
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}
