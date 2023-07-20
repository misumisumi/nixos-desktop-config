# libvirt conf
{
  pkgs,
  user,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      win-virtio
      virt-manager
      looking-glass-client
      dmidecode # Show BIOS info
    ];
  };
  users = {
    groups = {
      libvirt = {
        members = ["root" "${user}"];
      };
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true; # Virtual drivers
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        ovmf = {
          enable = true;
          packages = with pkgs; [pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd];
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
