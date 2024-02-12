{ pkgs, user, ... }:
{
  users.groups = {
    incus-admin.members = [ "root" "${user}" ];
    kvm.members = [ "root" "${user}" ];
  };
  virtualisation = {
    incus = {
      enable = true;
      startTimeout = 300;
    };
  };
}
