let
  inherit (import ../../path-relove.nix) commonDir appDir;
in
{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    ./virtualisation.nix
    ./own-system-conf.nix
  ] ++
  (import (appDir + "/virtualisation"));
}
