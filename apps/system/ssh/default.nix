{ config
, ...
}: {
  programs.ssh = {
    askPassword = "";
  };
  networking.firewall.allowedTCPPorts = config.services.openssh.ports;
  services.openssh = {
    enable = true;
    ports = [ 12511 ];
    extraConfig = ''
      UsePAM yes
    '';

    settings = {
      KbdInteractiveAuthentication = true;
      X11Forwarding = true;
    };
  };
}
