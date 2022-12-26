let
  inherit (import ../../path-relove.nix) commonDir appDir;
in
{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
  ]
  ++ (import (appDir + "/virtualisation"));
}
