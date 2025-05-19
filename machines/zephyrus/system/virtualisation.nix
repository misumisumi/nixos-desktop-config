{
  imports = [
    ../../../apps/system/virtualisation/incus
    ../../../apps/system/virtualisation/libvirt
    ../../../apps/system/virtualisation/podman
    ../../../apps/system/virtualisation/waydroid
  ];
  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
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
