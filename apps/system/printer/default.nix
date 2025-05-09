{ user, ... }:
{
  users.groups = {
    lp.members = [ "${user}" ];
    scanner.members = [ "${user}" ];
  };
  hardware.sane.enable = true;
  services = {
    printing.enable = true; # drivers are set on each machine
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    system-config-printer = {
      enable = true;
    };
  };
}
