{ hostname, pkgs, ... }:

{
  security.rtkit.enable = true;
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
    blueman.enable = true;
    udisks2.enable = true;
    dbus.packages = with pkgs; [ xfce.xfconf ];
    gvfs.enable = true;       # Mount, trash, and other functions
    tumbler.enable = true;    # Thumbnail supoport for images
  };
}
