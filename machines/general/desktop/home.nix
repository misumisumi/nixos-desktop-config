{ lib, hostname, pkgs, wm, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
{
  imports = (import (appDir + "/common/cli")) ++
            (import (appDir + "/common/git")) ++
            (import (appDir + "/common/neovim")) ++
            (import (appDir + "/common/shell")) ++
            (import (appDir + "/desktop") { inherit lib hostname; }) ++
            (import (appDir + "/desktop/wm/${wm}"));

  home = {
    packages = (import (appDir + "/common/pkgs") pkgs) ++
               (import (appDir + "/desktop/pkgs") { inherit pkgs; isMinimal = true; }) ++
               (import ./pkg.nix) pkgs;
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}
