/*
libvirt conf
*/
{ pkgs, user, ... }:

{
  # boot = {
  # extraModprobeConfig = ''
  #   options kvm_amd nested=1
  #   options kvm ignore_nsrs=1
  # '';
  # # kernelParams = [ "amd_iommu=on" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ]; 
  # # kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ];
  # # extraModprobeConfig = "options vfio-pci ids=1002:67DF,1002:AAF0";
  # };

  users = {
    groups = {
      libvirtd = {
        members = [ "root" "${user}" ];
      };
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;                          # Virtual drivers
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        ovmf = {
          enable = true;
          packages = with pkgs; [ OVMFFull ];
        };
        # verbatimConfig = ''
        #   nvram = [ 
        #     "${pkgs.OVMFFull}/FV/OVMF.fd:${pkgs.OVMFFull}/FV/OVMF_VARS.fd",
        #     "${pkgs.OVMFFull}/FV/OVMF.secboot.fd:${pkgs.OVMFFull}/FV/OVMF_VARS.fd",
        #   ]
        # '';
      };
    };
    spiceUSBRedirection.enable = true;        # USB passthrough
    sharedMemoryFiles = {
      looking-glass = {
        user = "${user}";
        group = "kvm";
        mode = "666";
      };
    };
  };
}
