# Streaming/Recording app
{ pkgs, ... }:
{
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        looking-glass-obs
        obs-pipewire-audio-capture
        droidcam-obs
        (obs-ndi.overrideAttrs (old: {
          patches = old.patches ++ [ ./obs-ndi.patch ];
        }))
      ];
    };
  };
}
