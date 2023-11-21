{ pkgs
, inputs
, stateVersion
, ...
}: {
  nixpkgs.config = {
    allowUnfree = true; # Allow proprietary software.
    allowBroken = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      substituters = [
        "https://misumisumi.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
    gc = {
      # 1週間ごとに7日前のイメージを削除
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable; # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;

    # flakeの有効化とビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    inherit stateVersion;
    # NixOS settings
    autoUpgrade = {
      # Allow auto update
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
