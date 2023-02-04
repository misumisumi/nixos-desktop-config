{ lib, hostname, pkgs, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
{
  imports = (import (appDir + "/common/cli")) ++
    (import (appDir + "/common/develop")) ++
    (import (appDir + "/common/git")) ++
    (import (appDir + "/common/neovim")) ++
    (import (appDir + "/common/shell")) ++
    (import (appDir + "/common/ssh")) ++
    (import (appDir + "/desktop") { inherit lib hostname; isFull = true; }) ++
    (import (appDir + "/desktop/wm/qtile"));

  home = {
    packages = (import (appDir + "/common/pkgs") pkgs) ++
      (import (appDir + "/desktop/pkgs") { inherit lib pkgs; isFull = true; }) ++
      (import (appDir + "/virtualisation/pkgs") pkgs) ++
      (with pkgs; [ prime-run ]);
  };
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
