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
  # paseo-desktop
  environment.systemPackages = optional config.services.xserver.enable (
    inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.desktop.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + "npm run postinstall";
    })
  );

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
