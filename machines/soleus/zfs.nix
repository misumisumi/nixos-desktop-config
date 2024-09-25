{
  networking.hostId = "7dfa348e";
  imports = [ ../init/zfs.nix ];
  boot = {
    kernelParams = [ "nohibernate" ];
  };
  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
    autoSnapshot = {
      enable = true;
      daily = 7;
      flags = "-k -p --utc";
      frequent = 15;
      hourly = 24;
      monthly = 12;
      weekly = 4;
    };
  };
}
