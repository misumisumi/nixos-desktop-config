{
  virtualisation = {
    lxc.lxcfs.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
  };
}
