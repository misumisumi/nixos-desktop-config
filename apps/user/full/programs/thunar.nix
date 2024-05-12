{ pkgs, ... }:
let
  thunar-with-plugins = with pkgs.xfce; (thunar.override { thunarPlugins = [ thunar-volman thunar-archive-plugin thunar-media-tags-plugin tumbler ]; });
in
{
  home = {
    packages = with pkgs;
      with pkgs.xfce; [
        thunar-with-plugins
        xfconf
        exo

        shared-mime-info # For FileManager
        ffmpegthumbnailer
        gnome.file-roller
        lxde.lxmenu-data
      ];
  };
  xdg = {
    mimeApps.defaultApplications."inode/directory" = "thunar.desktop";
    configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=wezterm
      TerminalEmulatorDismissed=true
    '';
  };
  xfconf.settings = {
    thunar = {
      "misc-compact-view-max-chars" = 15;
    };
  };

  systemd.user.services = {
    thunar-daemon = {
      Unit = {
        Description = "Launch thunar as daemon";
      };
      Service = {
        Type = "dbus";
        ExecStart = "${thunar-with-plugins}/bin/thunar --daemon";
        BusName = "org.xfce.FileManager";
        KillMode = "process";
      };
    };
  };
}
