# Please add apps/security for enabling rtkit
{ lib
, pkgs
, user
, ...
}:
{
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    paprefs
    portaudio
  ];
  # environment.etc."pipewire/pipewire-pulse.conf".source = ./pipewire-conf/pipewire-pulse.conf;
  hardware.pulseaudio.enable = lib.mkForce false;
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
  sound.enable = lib.mkForce false;
  users.groups = {
    audio.members = [ "${user}" ];
  };
}
