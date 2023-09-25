{ lib
, user
, hostname
, pkgs
, ...
}:
with lib; {
  security = {
    rtkit.enable = true;
  };

  programs = {
    dconf.enable = true;
    udevil.enable = true;
  };

  hardware = {
    bluetooth = {
      enable =
        if hostname == "tsundere" || hostname == "vm"
        then false
        else true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket"; # Enable A2DP sink
        };
      };
    };
    opengl = {
      driSupport = true;
      # driSupport32Bit = true;
    };
  };

  services =
    {
      blueman.enable = true;
      udisks2.enable = true;
      dbus.packages = with pkgs; [ xfce.xfconf ];
      gvfs.enable = true; # Mount, trash, and other functions
      tumbler.enable = true; # Thumbnail supoport for images
    }
    // optionalAttrs (user != "general") {
      interception-tools = {
        enable = true;
        udevmonConfig = ''
          - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /home/${user}/.dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
            DEVICE:
              EVENTS:
                EV_KEY: [KEY_ENTER]
        '';
        plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
      };
    };
}
