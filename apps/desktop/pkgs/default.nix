/*
My need packages.
*/
pkgs: with pkgs; [
  scream                          # Audio Recivier (For windows VM)
  polkit_gnome                    # polkit

  gnuplot                         # CLI Plotter
  pandoc                          # Document Converter
  (texlive.combined {              # TexLive(Japanese support)
    inherit (texlive) scheme-small collection-langjapanese
  })
  conky
  android-tools

  mesa-demos                      # Graphics utility
  vulkan-tools

  font-manager

  i3lock                          # Screen Locker

  nomacs                          # Image Viewer

  xfce.thunar                     # GUI Filer and Plugins
  xfce.thunar-volman
  xfce.thunar-archive-plugin
  xfce.thunar-media-tags-plugin
  haskellPackages.thumbnail

  discord                         # Communicate
  slack

  audacity                        # GUI Sound Editor
  sox                             # CLI Sound Editor

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

