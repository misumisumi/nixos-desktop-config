{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    ./virtualisation.nix
    ./asusd.nix
    ../common/pulseaudio.nix
    ../common/printer.nix
    ../../apps/desktop/wm/qtile/xserver.nix
  ] ++
  (import ../../apps/virtualisation);
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
