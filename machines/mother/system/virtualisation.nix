{
  imports = [
    ../../apps/system/virtualisation/incus
    ../../apps/system/virtualisation/libvirt
    ../../apps/system/virtualisation/podman
    ../../apps/system/virtualisation/singularity
    ../../apps/system/virtualisation/waydroid
  ];
  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
      enableNestedVirtualization = true;
      devices = [
        "10de:2504"
        "10de:228e"
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
