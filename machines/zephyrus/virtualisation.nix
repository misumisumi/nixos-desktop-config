{
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
    scream.enable = true;
  };
}
