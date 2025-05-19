{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # android-tools
      # matlab # Followed by nix-matlab
      # sidequest                     # Meta Quest side loading tool
      audacity # GUI Sound Editor
      blender_4_2 # 3DCG modeling tool
      carla # audio plugin host
      gimp # image editor
      (google-fonts.override {
        fonts = [
          "BIZUDMincho"
          "BIZUDPMincho"
          "BIZUDGothic"
          "BIZUDPGothic"
        ];
      })
      gpick # color picker
      inkscape # SVG editor
      juce # VST plugin flamework
      krita # painting tool
      unityhub
      vrc-get # Unofficial VRChat package manager
      wavesurfer # pkgs from Sumi-Sumi/flakes
      yabridge # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
      yabridgectl # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
    ];
  };
}
