/*
Streaming/Recording app
*/
{ lib, hostname, pkgs, ... }:

with lib; {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        looking-glass-obs
        obs-pipewire-audio-capture
      ] 
      ++ optional (hostname != "general") obs-ndi;
    };
  };
}
