{ inputs, user, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      # flakeの有効化
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      # ビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
      keep-outputs = true;
      keep-derivations = true;
      substituters = [
        "https://misumisumi.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "root"
        "${user}"
      ];
    };
    gc = {
      # 1週間ごとに7日前のイメージを削除
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';
}
