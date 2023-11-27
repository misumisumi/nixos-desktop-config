{ wm, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./gpu.nix
      ./own-system-conf.nix
      ../../common/pulseaudio.nix
      ../../common/printer.nix
    ]
    ++ (import ../../../apps/systemWide/wm/${wm});
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 4
    '';
  };
}
