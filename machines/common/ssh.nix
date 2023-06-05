{
  lib,
  stateVersion,
  ...
}: {
  programs.ssh = {
    askPassword = "";
  };
  services.openssh =
    {
      enable = true;
      ports = [12511];
      extraConfig = ''
        UsePAM yes
      '';
    }
    // lib.attrsets.optionalAttrs (stateVersion <= "22.11") {
      kbdInteractiveAuthentication = true;
      forwardX11 = true;
    }
    // lib.attrsets.optionalAttrs (stateVersion > "22.11") {
      settings = {
        KbdInteractiveAuthentication = true;
        X11Forwarding = true;
      };
    };
}