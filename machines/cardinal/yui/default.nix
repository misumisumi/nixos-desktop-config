{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    ../common/pulseaudio.nix
  ] ++
  (import ../../apps/virtualisation);

  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
