{
  pkgs,
  user,
  ...
}:
{
  users.groups = {
    audio.members = [ "${user}" ];
  };
  boot.kernelModules = [
    "snd-seq"
    "snd-rawmidi"
  ];
  nixpkgs.config.pulseaudio = true; # 一部パッケージのビルド時にpulseaudioを使うように指示する
  environment.systemPackages = with pkgs; [
    portaudio
    pavucontrol
    paprefs
    jack2
  ];
  services = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull.override {
        jackaudioSupport = true;
        advancedBluetoothCodecs = true;
      }; # Enable extra codecs (AAC, APTX, APTX-HD and LDAC.)
      extraConfig = ''
        load-module module-dbus-protocol
        # # For container
        load-module module-native-protocol-unix auth-anonymous=1 socket=/run/user/1000/pulse/pulpul
      '';
    };
  };
}
