{ lib, hostname, pkgs, wm, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
with lib;
{
  imports = (import (appDir + "/common/cli")) ++
    (import (appDir + "/common/git")) ++
    (import (appDir + "/common/neovim")) ++
    (import (appDir + "/common/shell")) ++
    (import (appDir + "/desktop") { inherit lib hostname; } // optionalAttrs (wm == "qtile") { isMidium = true; }) ++
    (import (appDir + "/desktop/wm/${wm}"));

  home = {
    packages = (import (appDir + "/common/pkgs") pkgs) ++
      (import (appDir + "/desktop/pkgs") { inherit lib pkgs; } // optionalAttrs (wm == "qtile") { isMidium = true; }) ++
      (with pkgs; [ pacman arch-install-scripts ]);
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}
