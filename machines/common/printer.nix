{pkgs, ...}: {
  hardware.sane.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [cnijfilter2 ricoh-sp-c260series-ppd];
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
