{
  boot.supportedFilesystems = {
    nfs4 = true;
  };
  fileSystems = {
    "/disk/fs1" = {
      device = "fs1.spcom.ecei.tohoku.ac.jp:/";
      fsType = "nfs4";
      noCheck = true;
      options = [ "rw,hard,x-systemd.automount,x-systemd.mount-timeout=30,_netdev" ];
    };
    "/disk/fsn1" = {
      device = "fsn1.spcom.ecei.tohoku.ac.jp:/";
      fsType = "nfs4";
      noCheck = true;
      options = [ "rw,hard,x-systemd.mount-timeout=30,_netdev" ];
    };
  };
}
