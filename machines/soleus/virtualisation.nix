{
  imports = [
    ../../apps/virtualisation/podman
    ../../apps/virtualisation/singularity
  ];
  virtualisation = {
    vfio = {
      enable = true;
      enableNestedVirtualization = true;
      IOMMUType = "intel";
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
