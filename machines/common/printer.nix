{ pkgs, ... }:

{
  hardware.sane.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ cnijfilter2 ];
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
