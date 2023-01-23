# My need packages.
{ pkgs, isMinimal ? false }:
let
  lib = pkgs.lib;
  tex = (pkgs.texlive.combine {
    # TexLive(Japanese support)
    inherit (pkgs.texlive) scheme-medium latexmk collection-langjapanese collection-latexextra;
  });
in
with pkgs; [
  man-pages # manuals
  man-db
  texinfo

  mesa-demos # Graphics utility
  vulkan-tools
  polkit_gnome # polkit

  gnuplot # CLI Plotter
  pandoc # Document Converter
  tex # tex
  texlab

  font-manager

  i3lock # Screen Locker

  nomacs # Image Viewer

  shared-mime-info # For FileManager
  ffmpegthumbnailer
  evince
  gnome.file-roller
  lxde.lxmenu-data
  haskellPackages.thumbnail

  discord # Communications

  audacity # GUI Sound Editor
  sox # CLI Sound Editor

  playerctl # CLI control media

  imagemagick # CLI Image Editor

  firefox # Browser

  spotify # Music Streaming
  spotify-tui # CLI tools for spotify

  gnome.simple-scan # Scaner
  baobab # Disk Usage Analyzer

  zathura # PDF viewer
] ++
lib.optionals (! isMinimal) [
  (vivaldi.override { proprietaryCodecs = true; }) # Browser

  wavesurfer # pkgs from Sumi-Sumi/flakes
  prime-run

  scream # Audio Recivier (For windows VM)
  conky
  android-tools

  slack # Communications
  zoom-us
  element-desktop
  ferdium

  blender # Creative Utility
  krita
  #gmic-qt-krita
  gpick
  gimp
  inkscape
  unityhub-latest

  copyq # Clipboard Manager
  # sidequest                     # Meta Quest side loading tool

  remmina # Remote desktop client

  zotero # Paper managiment tool

  juce # VST plugin flamework

  wpsoffice
]
