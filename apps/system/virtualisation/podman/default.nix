{ pkgs, ... }: {
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };

    oci-containers = {
      backend = "podman";
    };
  };

  environment = {
    etc."nvidia-container-runtime/config.toml".source = "${pkgs.nvidia-podman}/etc/nvidia-container-runtime/config.toml";
    systemPackages = with pkgs; [
      buildah
    ];
  };
}
