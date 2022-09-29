#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./machines
#   │   └─ configuration.nix *
#   └─ ./modules
#       └─ ./editors
#           └─ ./neovim
#               └─ default.nix
#
{ config, lib, pkgs, inputs, user, location, ... }:

let 
  commonPkgs = (import ../common);
  systemWidePythonPkgs = pythonPkgs: with pythonPkgs; commonPkgs.systemWidePythonPkgs;
  systemWidePython = pkgs.python3.withPackages systemWidePythonPkgs;
in
{
  imports = [];                             # Import window or display manager.

  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "lxd" "libvirt" "uucp" "kvm" "input" ];
    shell = pkgs.zsh;                       # Default shell
    subUidRanges = [
      {
        count = 100000;
        startUid = 300000;
      }
    ];
    subGidRanges = [
      {
        count = 100000;
        startGid = 300000;
      }
    ];
  };

  security.sudo.wheelNeedsPassword = true; # User does need to give password when using sudo.

  time.timeZone = "Asia/Tokyo";        # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";	                    # or us/azerty/etc
  };

  fonts.fonts = with pkgs; [                # Fonts
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    rictydiminished-with-firacode
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
        "HackNerd"
      ];
    })

    papirus-icon-theme                      # Icons
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; commonPkgs.systemPkgs ++ systemWidePython; # System wide pacakges
  };

  # sound = {                                 # ALSA sound enable(pipewireを有効にするときは消すかfalseにする)
  #   enable = true;
  #   mediaKeys = {                           # Keyboard Media Keys (for minimal desktop)
  #     enable = true;
  #   };
  # };
  security.rtkit.enable = true;
  services = {
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    openssh = {                             # SSH: secure shell (remote connection to shell of server)
      enable = true;                        # local: $ ssh <user>@<ip>
      ports = 12511;                        # public:
                                            #   - in case you want to use the domain name insted of the ip:
                                            #       - for me, via cloudflare, create an A record with name "ssh" to the correct ip without proxy
                                            #   - connect via ssh <user>@<ip or ssh.domain>
                                            # generating a key:
                                            #   - $ ssh-keygen   |  ssh-copy-id <ip/domain>  |  ssh-add
                                            #   - if ssh-add does not work: $ eval `ssh-agent -s`
      kbdInteractiveAuthentication = true;
      forwardX11 = true;
      extraConfig = 
      ''
        UsePAM yes
      '';
    };

  };
  # nix storeの肥大化を抑えるなどの最適化
  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # 1週間ごとに7日前のイメージを削除
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;               # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;

# flakeの有効化とビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
      # flakes = "github+ssh";  # リモートflakeの変更に自動で対応する
    };
    stateVersion = "22.05";
  };
}
