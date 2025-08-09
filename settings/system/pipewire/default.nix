# Please add apps/security for enabling rtkit
{
  config,
  pkgs,
  user,
  ...
}:
{
  # environment.etc."pipewire/pipewire-pulse.conf".source = ./pipewire-conf/pipewire-pulse.conf;
  security.rtkit.enable = true;
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "snd-aloop"
      "v4l2loopback"
    ];
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    paprefs
    portaudio
  ];
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
  users.groups = {
    audio.members = [ "${user}" ];
  };
}
