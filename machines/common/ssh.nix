{ pkgs, ... }:

{
  programs.ssh = {
    forwardX11 = true;
  };
  services.openssh = {
    enable = true;
    ports = [ 12511 ];
    kbdInteractiveAuthentication = true;
    extraConfig = 
    ''
      UsePAM yes
    '';
  };
}
