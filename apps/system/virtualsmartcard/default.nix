{
  pkgs,
  ...
}:
{
  services.pcscd.plugins = [ pkgs.python3Packages.virtualsmartcard ];
  networking.firewall.allowedTCPPorts = [
    35963 # for virtualsmartcard
    35964 # for virtualsmartcard
  ];
}
