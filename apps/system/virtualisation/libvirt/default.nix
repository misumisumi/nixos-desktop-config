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
    virt-manager
    virtiofsd
    win-virtio
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
