{ pkgs, ... }:

{
  services = {
    asusd.enable = true;
    asus-notify.enable = true;
    supergfxd.enable = true;
  };
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };
}
