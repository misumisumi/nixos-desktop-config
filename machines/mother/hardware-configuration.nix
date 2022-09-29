{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  networking = {
    useDHCP = false;
    hostname = "mother";
  };
}
