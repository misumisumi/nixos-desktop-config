{ lib, hostname, pkgs, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
{
  imports = (import (appDir + "/common/cli")) ++
            (import (appDir + "/common/git")) ++
            (import (appDir + "/common/neovim")) ++
            (import (appDir + "/common/shell")) ++
            (import (appDir + "/common/ssh")) ++
            (import (appDir + "/desktop") { inherit lib hostname; }) ++
            (import (appDir + "/desktop/wm/qtile")) ++
            (import ./home-own-conf.nix);

  home = {
    packages = (import (appDir + "/common/pkgs") pkgs) ++
               (import (appDir + "/desktop/pkgs") { inherit pkgs; }) ++
               (import (appDir + "/virtualisation/pkgs") pkgs);
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };

}
