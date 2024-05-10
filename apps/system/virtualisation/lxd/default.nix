{ user, ... }:
{
  users.groups = {
    lxd.members = [ "root" "${user}" ];
    kvm.members = [ "root" "${user}" ];
  };
  virtualisation = {
    lxc.lxcfs.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
  };
}
