# default is minimal desktop app
# "isMidium" add some utility
# "isLarge" add SNS and Creative tools
# "isFull" add my need pkg
{ lib
, pkgs
, isMidium ? false
, isLarge ? false
, isFull ? false
,
}:
with lib;
with pkgs;
[
  mesa-demos # OpenGL utility
  vulkan-tools # vulkan utility

  firefox # Browser
]
++ optionals (isMidium || isLarge || isFull) [
  i3lock # Screen Locker
  nomacs # Image Viewer
  font-manager # font-manger
  gnome.simple-scan # Scaner
  baobab # Disk Usage Analyzer
  copyq # Clipboard Manager
]
++ optionals (isLarge || isFull) [
  audacity # GUI Sound Editor
  blender # 3DCG modeling tool
  discord # chat
  element-desktop # matrix chat
  evince # PDF viewer
  gimp # image editor
  gnuplot # CLI Plotter
  gpick # color picker
  inkscape # SVG editor
  krita # painting tool
  libreoffice # Office
  poppler_utils # PDF utils
  pympress # PDF reader for presentations
  remmina # Remote desktop client
  slack # chat
  spotify # Music Streaming
  spotify-tui # CLI tools for spotify
  zathura # PDF viewer
  zoom-us # video conferencing app
  zotero # Paper managiment tool
]
++ optionals isFull [
  # sidequest                     # Meta Quest side loading tool
  android-tools
  carla
  ferdium # One place, Some webapp
  juce # VST plugin flamework
  matlab # Followed by nix-matlab
  unityhub
  vrc-get-latest # Unofficial VRChat package manager
  wavesurfer # pkgs from Sumi-Sumi/flakes
  yabridge # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
  yabridgectl # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
]
