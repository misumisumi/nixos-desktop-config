{ pkgs, ... }: {
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
  nixpkgs.config.pulseaudio = true; # 一部パッケージのビルド時にpulseaudioを使うように指示する
  sound.enable = true;
  environment.systemPackages = with pkgs; [
    portaudio
    pavucontrol
    paprefs
    jack2
  ];
  hardware = {
    pulseaudio = {
      enable = true;
      # support32Bit = true; # For 32bit apps
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
