{
  imports = [
    ../../../apps/system/virtualisation/incus
    ../../../apps/system/virtualisation/libvirt
    ../../../apps/system/virtualisation/podman
  ];
  virtualisation = {
    vfio = {
      enable = true;
      enableNestedVirtualization = true;
      IOMMUType = "amd";
      devices = [ ];
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
