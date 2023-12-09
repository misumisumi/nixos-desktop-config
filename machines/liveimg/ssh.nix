{ lib
, stateVersion
, ...
}: {
  programs.ssh = {
    askPassword = "";
  };
  services.openssh =
    {
      enable = true;
      ports = [ 22 ];
      extraConfig = ''
        UsePAM yes
      '';
      settings = {
        KbdInteractiveAuthentication = true;
      };
    };
}
