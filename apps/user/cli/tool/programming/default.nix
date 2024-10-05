# Manage language-specific packages in each project
# docker, podman, nix-flakes, and so on...
{ pkgs, ... }:
{
  home = {
    shellAliases = {
      actpd = "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock act";
    };
    packages = with pkgs; [
      act # Run your GitHub Actions locally
      update-github-actions-permissions # Update GitHub Actions permissions
    ];
  };
}
