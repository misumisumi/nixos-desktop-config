{
  lib,
  config,
  pkgs,
  self,
  hostname,
  ...
}:
let
  cfg = config.programs.poweroff';
in
with lib;
{
  options = {
    programs.poweroff'.enable = mkEnableOption "Check symlink targets in NixOS before shutting down the system.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages =
      let
        common =
          cmd:
          pkgs.writeShellScriptBin "${cmd}'" ''
            if ${config.nix.package}/bin/nix --experimental-features 'nix-command flakes' run --offline "${self}#nixosConfigurations.${hostname}.config.system.linkCheck"; then
              ${pkgs.systemd}/bin/${cmd}
            else
              echo ""
              echo -e "\033[31mFailed link check so stop ${cmd}!\033[0m" && exit 1
            fi
          '';
      in
      [
        (common "poweroff")
        (common "shutdown")
        (common "reboot")
      ];
  };
}
