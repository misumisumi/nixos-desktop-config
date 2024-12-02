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
        ovmf = {
          enable = true;
          packages = with pkgs; [ OVMFFull.fd ];
        };
        swtpm.enable = true;
        # verbatimConfig = ''
        #   nvram = [
        #     "${pkgs.OVMFFull}/FV/OVMF.fd:${pkgs.OVMFFull}/FV/OVMF_VARS.fd",
        #     "${pkgs.OVMFFull}/FV/OVMF.secboot.fd:${pkgs.OVMFFull}/FV/OVMF_VARS.fd",
        #   ]
        # '';
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
