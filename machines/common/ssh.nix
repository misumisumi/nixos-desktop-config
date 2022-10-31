{ pkgs, ... }:

{
  programs.ssh = {
    forwardX11 = true;
  };
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
