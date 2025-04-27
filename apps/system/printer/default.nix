{ pkgs, user, ... }:
{
  users.groups = {
    lp.members = [ "${user}" ];
    scanner.members = [ "${user}" ];
  };
  hardware.sane.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        cnijfilter2
        canon-cups-ufr2
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    system-config-printer = {
      enable = true;
    };
  };
}
