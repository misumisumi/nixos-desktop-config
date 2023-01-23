{ pkgs, ... }:

{
  programs.ssh = {
    askPassword = "";
  };
  services.openssh = {
    enable = true;
    ports = [ 12511 ];
    forwardX11 = true;
    settings = {
      KbdInteractiveAuthentication = true;
    };
    extraConfig =
      ''
        UsePAM yes
      '';
  };
}
