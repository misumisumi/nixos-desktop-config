{ pkgs, user, ... }:
{
  users.groups = {
    incus-admin.members = [ "root" "${user}" ];
    kvm.members = [ "root" "${user}" ];
  };
  environment.systemPackages = with pkgs; [ lxd-to-incus ];
  virtualisation = {
    incus = {
      enable = true;
      startTimeout = 300;
    };
  };
}
