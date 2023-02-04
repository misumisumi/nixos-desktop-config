# default is minimal desktop app
# "isMidium" add some utility
# "isLarge" add SNS and Creative tools
# "isFull" add my need pkg
{ lib, pkgs, addCLItools ? false, isMidium ? false, isLarge ? false, isFull ? false }:
with pkgs; [
  mesa-demos # Graphics utility
  vulkan-tools

  firefox # Browser
] ++ lib.optionals (addCLItools || isFull) (
  let
    texlive-combined = (pkgs.texlive.combine {
      # TexLive(Japanese support)
      inherit (pkgs.texlive) scheme-medium latexmk collection-langjapanese collection-latexextra;
    });
  in
  [
    zathura # PDF viewer
    sox # CLI Sound Editor
    graphicsmagick # CLI Image Editor
    playerctl # CLI control media
    gnuplot # CLI Plotter
    pandoc # Document Converter
    texlive-combined # LaTex
    pympress # PDF reader for presentations
    evince # PDF viewer
  ]
) ++ lib.optionals (isMidium || isLarge || isFull) [
  i3lock # Screen Locker
  nomacs # Image Viewer
  font-manager
  gnome.simple-scan # Scaner
  baobab # Disk Usage Analyzer
  copyq # Clipboard Manager
] ++ lib.optionals (isLarge || isFull) [
  libreoffice # Office
  remmina # Remote desktop client
  zotero # Paper managiment tool

  spotify # Music Streaming
  spotify-tui # CLI tools for spotify

  # Communications
  discord
  slack
  element-desktop
  zoom-us

  # Creative Utility
  audacity # GUI Sound Editor
  blender
  krita
  #gmic-qt-krita
  gpick
  gimp
  inkscape
] ++ lib.optionals isFull [
  (vivaldi.override { proprietaryCodecs = true; }) # Browser
  wavesurfer # pkgs from Sumi-Sumi/flakes
  android-tools
  ferdium # One place, Some webapp
  unityhub-latest
  juce # VST plugin flamework
  # sidequest                     # Meta Quest side loading tool
]
