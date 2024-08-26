{ inputs, user, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      # flakeの有効化
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # ビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
      keep-outputs = true;
      keep-derivations = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://misumisumi.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
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
