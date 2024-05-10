{ self, inputs, pkgs, user, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      # flakeの有効化
      experimental-features = [ "nix-command" "flakes" ];
      # ビルド時の依存関係を維持(オフラインでも再ビルド可能にする)
      keep-outputs = true;
      keep-derivations = true;
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
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  nixpkgs = {
    config = import ./nixpkgs-config.nix;
    overlays = [
      inputs.flakes.overlays.default
      inputs.nixgl.overlay
      inputs.nur.overlay
      self.overlays.default
    ];
  };
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
