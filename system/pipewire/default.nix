# Please add apps/security for enabling rtkit
{ pkgs, ... }: {
  sound.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    paprefs
    portaudio
  ];
  # environment.etc."pipewire/pipewire-pulse.conf".source = ./pipewire-conf/pipewire-pulse.conf;
}
