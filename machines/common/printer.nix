{ pkgs, ... }:

{
  hardware.sane.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ cnijfilter2 cups-brother-hll5100dn ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    system-config-printer = {
      enable = true;
    };
  };
}
