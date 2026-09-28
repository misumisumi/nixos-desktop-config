{
  inputs,
  lib,
  pkgs,
  config,
  user,
  ...
}:
let
  inherit (lib) optional;
in
{
  sops = {
    secrets."paseo/password" = {
      owner = user;
      group = "users";
      mode = "0400";
    };
    templates."paseo/env" = {
      owner = user;
      group = "users";
      content = "PASEO_PASSWORD=${config.sops.placeholder."paseo/password"}\n";
    };
  };
  systemd.services.paseo.serviceConfig.EnvironmentFile = config.sops.templates."paseo/env".path;

  # paseo-desktop
  environment.systemPackages =
    let
      paseo-desktop = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.desktop.override {
        electron = pkgs.electron_42;
      };
    in
    optional config.services.xserver.enable paseo-desktop;

  services.paseo = {
    enable = true;
    # A real user, not a system account: agents must see the user's own
    # toolchain (opencode, git, ssh keys). inheritUserEnvironment then adds
    # the user profile paths to the daemon's PATH.
    inherit user;

    relay = {
      enable = true;
      # "remote" points the daemon at our own relay instead of app.paseo.sh.
      mode = "remote";
      host = "relay.misumi-sumi.com";
      port = 443;
      useTls = true;
    };
  };
}
