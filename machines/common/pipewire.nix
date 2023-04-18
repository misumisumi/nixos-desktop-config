{pkgs, ...}: {
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
      # config = {
      #   client-rt = {
      #     filter.properties = {
      #       node.latency = "512/48000";
      #     };

      #     stream.properties = {
      #       node.latency = "512/48000";
      #       #node.autoconnect      = true
      #       #resample.quality      = 4
      #       #channelmix.normalize  = false
      #       #channelmix.mix-lfe    = true
      #       #channelmix.upmix      = true
      #       #channelmix.upmix-method = psd  # none, simple
      #       #channelmix.lfe-cutoff = 150
      #       #channelmix.fc-cutoff  = 12000
      #       #channelmix.rear-delay = 12.0
      #       #channelmix.stereo-widen = 0.0
      #       #channelmix.hilbert-taps = 0
      #       #dither.noise = 0
      #     };
      #   };
      #   client = {
      #     filter.properties = {
      #       node.latency = "512/48000";
      #     };

      #     stream.properties = {
      #       node.latency = "512/48000";
      #       #node.autoconnect      = true
      #       #resample.quality      = 4
      #       #channelmix.normalize  = false
      #       #channelmix.mix-lfe    = true
      #       #channelmix.upmix      = true
      #       #channelmix.upmix-method = psd  # none, simple
      #       #channelmix.lfe-cutoff = 150
      #       #channelmix.fc-cutoff  = 12000
      #       #channelmix.rear-delay = 12.0
      #       #channelmix.stereo-widen = 0.0
      #       #channelmix.hilbert-taps = 0
      #       #dither.noise = 0
      #     };
      #   };
      #   pipewire-pulse = {
      #     pulse.properties = {
      #       # the addresses this server listens on
      #       server.address = [
      #         "unix:native"
      #         "unix:/run/user/1000/pulse/pulpul"
      #         #"tcp:4713"                         # IPv4 and IPv6 on all addresses
      #         #"tcp:[::]:9999"                    # IPv6 on all addresses
      #         #"tcp:127.0.0.1:8888"               # IPv4 on a single address
      #         #
      #         #{ address = "tcp:4713"             # address
      #         #  max-clients = 64                 # maximum number of clients
      #         #  listen-backlog = 32              # backlog in the server listen queue
      #         #  client.access = "restricted"     # permissions for clients
      #         #}
      #       ];
      #       #pulse.min.req          = 256/48000     # 5ms
      #       #pulse.default.req      = 960/48000     # 20 milliseconds
      #       #pulse.min.frag         = 256/48000     # 5ms
      #       #pulse.default.frag     = 96000/48000   # 2 seconds
      #       #pulse.default.tlength  = 96000/48000   # 2 seconds
      #       #pulse.min.quantum      = 256/48000     # 5ms
      #       #pulse.idle.timeout     = 0             # don't pause after underruns
      #       #pulse.default.format   = F32
      #       #pulse.default.position = [ FL FR ]
      #     };
      #   };
      #   jack = {
      #     jack.properties = {
      #       #node.latency       = 1024/48000
      #       #node.rate          = 1/48000
      #       #node.quantum       = 1024/48000
      #       #node.lock-quantum  = true
      #       #node.force-quantum = 0
      #       #jack.show-monitor  = true
      #       #jack.merge-monitor = true
      #       #jack.short-name    = false
      #       #jack.filter-name   = false
      #       #jack.filter-char   = " "
      #       #
      #       # allow:           Don't restrict self connect requests
      #       # fail-external:   Fail self connect requests to external ports only
      #       # ignore-external: Ignore self connect requests to external ports only
      #       # fail-all:        Fail all self connect requests
      #       # ignore-all:      Ignore all self connect requests
      #       jack.self-connect-mode = "allow";
      #       #jack.locked-process    = true
      #       #jack.default-as-system = false
      #       #jack.fix-midi-events   = true
      #       #jack.global-buffer-size = false
      #     };
      #   };
      # };
    };
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    paprefs
    cadence
    portaudio
  ];
}
