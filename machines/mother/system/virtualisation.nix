{
  imports = [
    ../../../apps/system/virtualisation/incus
    ../../../apps/system/virtualisation/libvirt
    ../../../apps/system/virtualisation/podman
    ../../../apps/system/virtualisation/waydroid
  ];
  boot.kernelParams = [ "kvm_amd.avic=1" ];
  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
      enableNestedVirtualization = true;
      devices = [
        "10de:2c05"
        "10de:22e9"
        "1e0f:0009"
      ];
      # deviceDomains = [ "0000:09:00.0" "0000:09:00.1" ];
      blacklistNvidia = false;
      disableEFIfb = false;
      ignoreMSRs = true;
      applyACSpatch = false;
    };
    hugepages = {
      enable = false;
      defaultPageSize = "1G";
      pageSize = "1G";
      numPages = 16;
    };
  };
}
