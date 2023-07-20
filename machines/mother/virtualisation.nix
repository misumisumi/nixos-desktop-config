{
  imports = [
    ../../apps/systemWide/virtualisation/libvirt
    ../../apps/systemWide/virtualisation/lxd
    ../../apps/systemWide/virtualisation/podman
    ../../apps/systemWide/virtualisation/singularity
    ../../apps/systemWide/virtualisation/waydroid
  ];
  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
      devices = ["10de:2204" "10de:1aef"];
      # deviceDomains = ["0000:09:00.0" "0000:09:00.1"];
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