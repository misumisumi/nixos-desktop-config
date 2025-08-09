{ pkgs, ... }:
{
  boot.kernelModules = [
    "usbip_host"
    "vhci_hcd"
  ];
  networking.firewall.allowedTCPPorts = [
    3240
  ];
  environment.systemPackages = with pkgs; [
    linuxPackages.usbip
  ];
}
