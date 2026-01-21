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
    cdrtools # For mkisofs
    dmidecode # Show BIOS info
    hwloc # Show CPU topology
    virt-manager
    virtio-win
    (
      let
        inherit (builtins) readFile;
      in
      pkgs.writeShellScriptBin "motherboard2libvirt-xml" (readFile ./motherboard2libvirt-xml.sh)
    )
  ];
  virtualisation = {
    libvirtd = {
      enable = true; # Virtual drivers
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
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
