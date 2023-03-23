# default is minimal desktop app
# "isMidium" add some utility
# "isLarge" add SNS and Creative tools
# "isFull" add my need pkg
{ lib, pkgs, isMidium ? false, isLarge ? false, isFull ? false }:
with lib; with pkgs; [
  mesa-demos # Graphics utility
  vulkan-tools

  firefox # Browser
] ++ optionals (isMidium || isLarge || isFull) [
  i3lock # Screen Locker
  nomacs # Image Viewer
  font-manager
  gnome.simple-scan # Scaner
  baobab # Disk Usage Analyzer
  copyq # Clipboard Manager
] ++ optionals (isLarge || isFull) [
  gnuplot # CLI Plotter
  pympress # PDF reader for presentations
  zathura # PDF viewer
  evince # PDF viewer

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
] ++ optionals isFull
  (
    let
      dotnetPkg =
        (with pkgs.dotnetCorePackages; combinePackages [
          sdk_6_0
        ]);
      dotnetTools = (callPackage ./dotnet-tool.nix { });     # dotnet-tool.nix is the file from the link above
    in
    [
      (vivaldi.override { proprietaryCodecs = true; }) # Browser
      wavesurfer # pkgs from Sumi-Sumi/flakes
      android-tools
      ferdium # One place, Some webapp
      unityhub-latest
      juce # VST plugin flamework
      # sidequest                     # Meta Quest side loading tool
    ]
  )
