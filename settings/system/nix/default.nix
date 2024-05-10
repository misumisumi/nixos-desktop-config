{ self
, config
, pkgs
, inputs
, user
, ...
}:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      # flakeの有効化
      experimental-features = [ "nix-command" "flakes" ];
      # ビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true; # Optimise syslinks
      substituters = [
        "https://misumisumi.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
      trusted-users = [ "root" "${user}" ];
    };
    gc = {
      # 1週間ごとに7日前のイメージを削除
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;

  };
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      inputs.nixgl.overlay
      inputs.flakes.overlays.default
      self.overlays.default
    ];
    config = { allowUnfree = true; };
  };

  system = {
    stateVersion = config.system.nixos.release;
    # NixOS settings
    autoUpgrade = {
      # Allow auto update
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
