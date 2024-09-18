{ config, ... }:
{
  boot = {
    loader.timeout = 10;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };
  services = {
    openssh.ports = [ 22 ];
    xserver.displayManager.gdm.autoSuspend = false;
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
  services.pipewire.extraConfig.pipewire-pulse = {
    native-protocol-tcp = {
      pulse.cmd = [
        {
          cmd = "load-module";
          args = "module-tunnel-sink";
          flags = [ "server=tcp:133.24.91.38:4656" ];
        }
      ];
    };
  };
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
