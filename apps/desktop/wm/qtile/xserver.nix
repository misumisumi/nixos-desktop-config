{
  imports = [ ../common/xserver.nix ];

  services.xserver.displayManager.defaultSession = "none+xsession";
}
