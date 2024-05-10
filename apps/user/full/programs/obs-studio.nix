# Streaming/Recording app
{ lib
, hostname
, pkgs
, ...
}:
with lib; {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs;
        with pkgs.obs-studio-plugins;
        [
          looking-glass-obs
          obs-pipewire-audio-capture
          droidcam-obs
        ]
        ++ optional (hostname != "liveimg") obs-ndi;
    };
  };
}
