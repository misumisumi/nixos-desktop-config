/*
My need packages.
*/
pkgs: 
let
  tex = (pkgs.texlive.combine {       # TexLive(Japanese support)
      inherit (pkgs.texlive) scheme-small collection-langjapanese;
  });
  # thunar-with-plugins = with pkgs.xfce; (thunar.override { thunarPlugins = [ thunar-volman thunar-archive-plugin thunar-media-tags-plugin ]; });
in
with pkgs; [
  wavesurfer                      # pkgs from Sumi-Sumi/flakes
  prime-run

  scream                          # Audio Recivier (For windows VM)
  polkit_gnome                    # polkit

  gnuplot                         # CLI Plotter
  pandoc                          # Document Converter
  tex
  conky
  android-tools

  mesa-demos                      # Graphics utility
  vulkan-tools

  font-manager

  i3lock                          # Screen Locker

  nomacs                          # Image Viewer

  # thunar-with-plugins             # GUI Filer and Plugins
  pcmanfm
  shared-mime-info
  ffmpegthumbnailer
  evince
  gnome.file-roller
  lxde.lxmenu-data
  haskellPackages.thumbnail

  discord                         # Communicate
  slack

  audacity                        # GUI Sound Editor
  sox                             # CLI Sound Editor

  imagemagick                     # CLI Image Editor

  firefox                         # Browser
  vivaldi
  vivaldi-ffmpeg-codecs

  spotify                         # Music Streaming
  spotify-tui                     # CLI tools for spotify

  blender                         # Creative Utility
  krita
  gmic-qt-krita
  gpick
  inkscape
  unityhub

  gnome.simple-scan               # Scaner
  baobab                          # Disk Usage Analyzer

  nextcloud-client
  zathura                         # Paper Manager

  copyq                           # Clipboard Manager
  # sidequest                     # Meta Quest side loading tool
]

