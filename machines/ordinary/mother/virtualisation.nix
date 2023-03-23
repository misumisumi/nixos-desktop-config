{
  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
      devices = [ ];
      # devices = [ "10de:2204" "10de:1aef" ];
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
  boot.initrd = {
    preDeviceCommands = ''
      DEVS="0000:09:00.0 0000:09:00.1"
      if [ -z "$(ls -A /sys/class/iommu)" ]; then
        exit 0
      fi
      for DEV in $DEVS; do
        echo "vfio-pci" > "/sys/bus/pci/devices/$DEV/driver_override"
      done
    '';
  };
  systemd.services.vfio-load = {
    description = "Insert vfio-pci driver";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/modprobe -i vfio-pci";
    };
  };
}
