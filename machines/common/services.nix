{ hostname, pkgs, ... }:

{
  security.rtkit.enable = true;
  nixpkgs.config.pulseaudio = true;             # 一部パッケージのビルド時にpulseaudioを使うように指示する
  hardware = {
    pulseaudio = {
      enable = true;
      # support32Bit = true; # For 32bit apps
      package = pkgs.pulseaudioFull;            # Enable extra codecs (AAC, APTX, APTX-HD and LDAC.)
      extraConfig = ''
        load-module module-native-protocol-unix
        # For container
        load-module module-native-protocol-unix auth-anonymous=1 socket=/run/user/1000/pulse/pulpul
      '';
    };

    bluetooth = {
      enable = if hostname == "tsundere" || hostname == "vm" then false else true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";  # Enable A2DP sink
        };
      };
    };
    opengl = {
      driSupport = true;
      # driSupport32Bit = true;
    };
  };

  services = {
  #   pipewire = {
  #     enable = true;
  #     alsa = {
  #       enable = true;
  #       support32Bit = true;
  #     };
  #     pulse.enable = true;
  #   };

    openssh = {
      enable = true;
      ports = [ 12511 ];
      kbdInteractiveAuthentication = true;
      forwardX11 = true;
      extraConfig = 
      ''
        UsePAM yes
      '';
    };
  };

}
