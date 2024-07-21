{ pkgs
, ...
}:
{
  home = {
    shellAliases = {
      actpd = "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock act";
    };
    packages = with pkgs; [
      # android-tools
      # matlab # Followed by nix-matlab
      # sidequest                     # Meta Quest side loading tool
      act # Run your GitHub Actions locally
      asunder # CD ripper
      audacity # GUI Sound Editor
      baobab # Disk Usage Analyzer
      blender # 3DCG modeling tool
      carla # audio plugin host
      copyq # Clipboard Manager
      discord # chat
      droidcam
      element-desktop # matrix chat
      evince # PDF viewer
      ferdium # One place, Some webapp
      font-manager # font-manger
      gimp # image editor
      gnuplot # CLI Plotter
      google-fonts
      gpick # color picker
      i3lock # Screen Locker
      inkscape # SVG editor
      ipaexfont # Japanese font package with Mincho and Gothic fonts
      juce # VST plugin flamework
      krita # painting tool
      libreoffice # Office
      looking-glass-client # A KVM Frame Relay (KVMFR) implementation
      mesa-demos # OpenGL utility
      nomacs # Image Viewer
      obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
      pympress # PDF reader for presentations
      remmina # Remote desktop client
      simple-scan # Scaner
      slack # chat
      sops # secrets management
      unityhub
      update-github-actions-permissions # Update GitHub Actions permissions
      vrc-get # Unofficial VRChat package manager
      vulkan-tools # vulkan utility
      wavesurfer # pkgs from Sumi-Sumi/flakes
      yabridge # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
      yabridgectl # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
      zoom-us # video conferencing app
    ];
  };
}
