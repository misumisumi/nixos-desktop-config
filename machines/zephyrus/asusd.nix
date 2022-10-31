{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ supergfxctl ];
  services.asusd.enable = true;
  services.asus-notify.enable = true;
  services.supergfxd.enable = true;
}
