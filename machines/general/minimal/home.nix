{ lib, hostname, config, pkgs, ... }:
let
  inherit (import ../../path-relove.nix) appDir;
in
{
  imports = (import (appDir + "/common/cli")) ++
            (import (appDir + "/common/git")) ++
            (import (appDir + "/common/neovim")) ++
            (import (appDir + "/common/shell"));
}
