{
  pkgs,
  config,
  user,
  ...
}:
{
  boot = {
    loader.timeout = 10;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
  };
  users.users.${user}.extraGroups = [ "user" ];
  environment.systemPackages = with pkgs; [
    canon-cups-ufr2
  ];
  services = {
    printing = {
      drivers = with pkgs; [
        cnijfilter2
        canon-cups-ufr2
      ];
      allowFrom = [
        "localhost"
        "172.20.110.241"
      ];
    };
    pipewire.extraConfig.pipewire-pulse = {
      native-protocol-tcp = {
        pulse.cmd = [
          {
            cmd = "load-module";
            args = "module-native-protocol-tcp";
            flags = [
              "port=4656"
              "auth-anonymous=1"
            ];
          }
        ];
      };
    };
  };
  nix = {
    settings = {
      cores = 4;
      max-jobs = 3;
    };
    extraOptions = ''
      http-connections = 50
    '';
  };
}
