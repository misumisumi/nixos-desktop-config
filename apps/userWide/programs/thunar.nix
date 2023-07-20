{pkgs, ...}: let
  thunar-with-plugins = with pkgs.xfce; (thunar.override {thunarPlugins = [thunar-volman thunar-archive-plugin thunar-media-tags-plugin];});
in {
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
      haskellPackages.thumbnail
    ];
  };
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
    TerminalEmulatorDismissed=true
  '';
}
