{ pkgs, ... }:

{
  # programs.ssh = {
  #   forwardX11 = true;
  # };
  services.openssh = {
    enable = true;
    ports = [ 12511 ];
    forwardX11 = true;
    kbdInteractiveAuthentication = true;
    extraConfig = 
    ''
      UsePAM yes
    '';
  };
}
