# Streaming/Recording app
{ pkgs, ... }:
{
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-ndi
        (looking-glass-obs.overrideAttrs (
          final: prev: {
            nativeBuildInputs = prev.nativeBuildInputs ++ [
              pkgs.libGL
            ];
          }
        ))
      ];
    };
  };
}
