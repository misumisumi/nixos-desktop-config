# libvirt conf
{ pkgs, user, ... }:
{
  users.groups = {
    libvirt.members = [
      "root"
      "${user}"
    ];
    kvm.members = [
      "root"
      "${user}"
    ];
  };
  environment.systemPackages = with pkgs; [
    dmidecode # Show BIOS info
    hwloc # Show CPU topology
    virt-manager
    virtio-win
    virtiofsd
  ];
  virtualisation = {
    libvirtd = {
      enable = true; # Virtual drivers
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true; # USB passthrough
    sharedMemoryFiles = {
      looking-glass = {
        user = "${user}";
        group = "kvm";
        mode = "660";
      };
    };
  };
}
