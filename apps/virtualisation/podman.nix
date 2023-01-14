/*
  Podman conf
*/
{ pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      enableNvidia = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };

    oci-containers = {
      backend = "podman";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      buildah
    ];
  };
}
