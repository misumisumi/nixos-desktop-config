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
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
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
