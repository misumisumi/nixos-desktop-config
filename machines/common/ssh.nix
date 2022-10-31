{ pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 12511 ];
    kbdInteractiveAuthentication = true;
    forwardX11 = true;
    extraConfig = 
    ''
      UsePAM yes
    '';
  };
}
