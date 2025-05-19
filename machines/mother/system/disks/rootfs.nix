{
  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=2G"
          "mode=755"
        ];
      };
    };
  };
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "25%";
  };
}
