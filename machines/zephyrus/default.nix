{
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./gpu.nix
      ./virtualisation.nix
      ./own-system-conf.nix
      ../common/pipewire.nix
      ../common/printer.nix
    ]
    ++ (import ../../apps/systemWide/wm/qtile);
}