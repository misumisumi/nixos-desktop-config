{ lib, hostname, pkgs, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
{
  imports = (import (appDir + "/common/cli")) ++
    (import (appDir + "/common/programs")) ++
    (import (appDir + "/common/git")) ++
    (import (appDir + "/common/neovim")) ++
    (import (appDir + "/common/shell")) ++
    (import (appDir + "/common/ssh")) ++
    (import (appDir + "/desktop") { inherit lib hostname; isLarge = true; }) ++
    (import (appDir + "/desktop/wm/qtile"));

  home = {
    packages = (import (appDir + "/common/pkgs") { inherit lib pkgs; isLarge = true; }) ++
      (import (appDir + "/desktop/pkgs") { inherit lib pkgs; isFull = true; }) ++
      (import (appDir + "/virtualisation/pkgs") pkgs) ++
      (with pkgs; [ evtest xp-pen-driver ]);
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
