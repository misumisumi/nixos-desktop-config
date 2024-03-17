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
      preseed = {
        networks = [
          {
            description = "Default Incus network";
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
            name = "incusbr0";
            type = "bridge";
          }
        ];
        profiles = [
          {
            description = "Default Incus profile";
            devices = {
              eth0 = {
                "name" = "eth0";
                "nictype" = "bridged";
                "parent" = "incusbr0";
                "type" = "nic";
              };
              root = {
                "path" = "/";
                "pool" = "default";
                "type" = "disk";
              };
            };
            name = "default";
          }
        ];
        storage_pools = [
          {
            config = {
              size = "16GiB";
              source = "/var/lib/incus/disks/default.img";
            };
            description = "Default Incus storage";
            name = "default";
            driver = "btrfs";
          }
        ];
      };
    };
  };
}
