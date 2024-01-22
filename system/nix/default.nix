{ config
, pkgs
, inputs
, system
, stateVersion
, user
, ...
}:
{
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
      trusted-users = [ "root" "${user}" ];
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
  nixpkgs = {
    overlays =
      let
        nixpkgs-stable = import inputs.nixpkgs-stable {
          inherit (config.nixpkgs) system;
          config = { allowUnfree = true; };
        };
      in
      [
        inputs.nur.overlay
        inputs.nixgl.overlay
        inputs.flakes.overlays.default
        inputs.dotfiles.overlays.default
        (import ../../patches { inherit nixpkgs-stable; })
      ];
    config = { allowUnfree = true; };
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
