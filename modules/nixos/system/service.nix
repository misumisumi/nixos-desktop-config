{
  self,
  lib,
  config,
  hostname,
  user,
  ...
}:
let
  cfg = config.services.checkLinkBeforeShutdown;
in
with lib;
{
  options = {
    services.checkLinkBeforeShutdown = {
      enable = mkEnableOption "Check symlink targets in NixOS before shutting down the system.";
    };
  };
  config = mkIf cfg.enable {
    systemd.services = {
      pre-shutdown-nixos-link-check = {
        description = "Check symlink targets before shutting down the system";
        before = [ "shutdown.target" ];
        wantedBy = [
          "shutdown.target"
        ];
        unitConfig = {
          DefaultDependencies = "no";
        };
        environment = {
          HOME = "${config.users.users.${user}.home}";
          SUDO_USER = "${user}"; # Needed for home-manager scripts
        };
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${config.nix.package}/bin/nix --experimental-features 'nix-command flakes' run --offline ${self}#nixosConfigurations.${hostname}.config.system.linkCheck";
          RemainAfterExit = true;
        };
      };
    };
  };
}
