{
  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=3G"
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
