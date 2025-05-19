{
  environment.variables.NIX_REMOTE = "daemon"; # force use nix-daemon from root
  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix"; # tmpdir on physical storage
    };
    serviceConfig = {
      CacheDirectory = "nix"; # auto create /var/cache/nix on nix-daemon start
    };
  };
}
