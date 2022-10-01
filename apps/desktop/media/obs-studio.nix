{ pkgs, ... }:

{
  programs = {
    obs-studio = {
      enable = true;
      plugins = [
        "obs-studio-plugins.obs-ndi"
        "obs-studio-plugins.looking-glass-obs"
        "obs-studio-plugins.obs-pipewire-audio-capture"
        pkgs.fetchFromGitHub {
          owner = "dev47apps";
          repo = "droidcam-obs-plugin";
          rev = "1.6.0";
          sha256 = "083pv2l8d1hnfz00y0dfaid87qxwzn23077ciz5z4rn118rxkfr0";
        }
      ];
    };
  };
}
