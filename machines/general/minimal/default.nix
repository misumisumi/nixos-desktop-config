{
  pkgs,
  wm,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    ./own-system-conf.nix
  ];

  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
