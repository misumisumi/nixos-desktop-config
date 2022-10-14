{ hostname, pkgs, ... }:

{
  security.rtkit.enable = false;
  programs = {
    dconf.enable = true;
    udevil.enable = true;
  };
  hardware = {
    bluetooth = {
      enable = if hostname == "tsundere" || hostname == "vm" then false else true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";  # Enable A2DP sink
        };
      };
    };
    opengl = {
      driSupport = true;
      # driSupport32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    paprefs
  ];

  services = {
    udisks2.enable = true;
    openssh = {
      enable = true;
      ports = [ 12511 ];
      kbdInteractiveAuthentication = true;
      forwardX11 = true;
      extraConfig = 
      ''
        UsePAM yes
      '';
    };
  };
}
