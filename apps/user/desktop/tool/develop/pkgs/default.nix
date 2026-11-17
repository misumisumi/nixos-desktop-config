{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # android-tools
    # matlab # Followed by nix-matlab
    # sidequest                     # Meta Quest side loading tool
    audacity # GUI Sound Editor
    blender-bin # 3DCG modeling tool
    (gimp3-with-plugins.override {
      plugins = with gimp3Plugins; [
        gmic
        lightning
      ];
    }) # image editor with plugins
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
  ];
}
