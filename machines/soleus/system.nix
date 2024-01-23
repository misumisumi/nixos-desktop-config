{ config, ... }: {
  boot = {
    loader.timeout = 10;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };
  services.openssh.ports = [ 22 ];
  nix = {
    settings = {
      cores = 4;
      max-jobs = 2;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 8
    '';
  };
}

