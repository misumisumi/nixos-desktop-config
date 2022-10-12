# Conf for nix package manager
{ pkgs, inputs, stateVersion, ... }:

{
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # 1週間ごとに7日前のイメージを削除
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable;               # Enable nixFlakes on system
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
    stateVersion = "${stateVersion}";
  };
}
