{ pkgs, ... }:

{
  programs = {
    obs-studio = {
      enable = true;
      plugins = [
        pkgs.fetchFromGitHub {
          owner = "dev47apps";
          repo = "droidcam-obs-plugin";
          rev = "1.6.0";
          sha256 = "083pv2l8d1hnfz00y0dfaid87qxwzn23077ciz5z4rn118rxkfr0";
        }
      ] ++ with pkgs.obs-studio-plugins; [
        obs-ndi
        looking-glass-obs
        obs-pipewire-audio-capture
      ];
    };
  };
}
