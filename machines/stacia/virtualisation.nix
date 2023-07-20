{
  imports = [
    ../../apps/systemWide/virtualisation/lxd
    ../../apps/systemWide/virtualisation/podman
    ../../apps/systemWide/virtualisation/singularity
  ];
  virtualisation = {
    vfio = {
      enable = true;
      enableNestedVirtualization = true;
      IOMMUType = "amd";
      devices = [];
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
    scream.enable = true;
  };
}
