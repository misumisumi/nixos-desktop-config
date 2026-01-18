{
  lib,
  pkgs,
  config,
  user,
  self,
  ...
}:
with lib;
{
  options = {
    system.linkCheck = mkOption {
      type = types.package;
      internal = true;
    };
  };
  config = {
    system.linkCheck =
      let
        storeDir = lib.escapeShellArg builtins.storeDir;
        dontCheck = [ "resolv.conf" ];
        srcTargetPathes = lib.concatStringsSep " " (
          lib.mapAttrsToList (name: value: "${value.source}=${value.target}") (
            lib.filterAttrs (n: v: (all (x: x != n) dontCheck) && v.mode == "symlink") config.environment.etc
          )
        );
        check = pkgs.replaceVarsWith {
          src = ./check-link-targets.sh;
          isExecutable = true;
          replacements = {
            inherit storeDir srcTargetPathes;
          };
        };
      in
      pkgs.writeShellScriptBin "nixos-link-check" ''
        ${check}
        ${optionalString
          (
            builtins.hasAttr "home-manager" config
            && builtins.hasAttr "linkCheck" config.home-manager.users.${user}.home
          )
          ''
            if [ -z "''${SUDO_USER}" ]; then
              ${config.home-manager.users.${user}.home.linkCheck}/bin/home-manager-link-check
            else
              ${pkgs.sudo}/bin/sudo -u "''${SUDO_USER}" ${
                config.home-manager.users.${user}.home.linkCheck
              }/bin/home-manager-link-check
            fi
          ''
        }
      '';
    #NOTE: nixos-rebuild-ng have been default since 25.11
    # Old nixos-rebuild cmd can use by settings system.rebuild.enableNg = false but this option will be removed in the future
    # So I override the nixos-rebuild to always use nixos-rebuild-ng here with custom wrapper script
    system.build.nixos-rebuild = lib.mkForce (
      pkgs.writeShellScriptBin "nixos-rebuild" ''
        set -euo pipefail

        parse_params() {
          # default values of variables set from params
          count=0
          flake=""
          boot=0
          offline=0
          check_kernel=0
          while (( $# > 0 )) do
            count=''$((count + 1))
            case "''${1-}" in
            --flake)
              shift
              flake=''${1-}
              flake=''${flake//.*#/}
              count="''$((count + 1))"
              ;;
            --offline)
              offline=1
              ;;
            boot) boot=1
              ;;
            switch) check_kernel=1
              ;;
            test) check_kernel=1
              ;;
            esac
            shift
          done

          count="''$((count + 1))"
          return 0
        }

        parse_params "''$@"
        if [ "''${SHLVL}" -eq 1 ] && [ "''${flake}" != "" ]; then
          current_kernel="$(${pkgs.coreutils}/bin/uname -r)"
          cmd="${pkgs.nix}/bin/nix eval "${self}#nixosConfigurations.''${flake}.config.boot.kernelPackages.kernel.version" --raw"
          if [ "''${offline}" -eq 0 ]; then
            cmd="''${cmd} --refresh"
          else
            cmd="''${cmd} --offline"
          fi
          next_kernel="$(eval "''${cmd}")"
          echo "Kernel version: ''${current_kernel} -> ''${next_kernel}"
          if [ "''${current_kernel}" != "''${next_kernel}" ] && [ "''${check_kernel}" -eq 1 ]; then
            echo "Need to reboot so use `nixos-rebuild boot`"
            exit 1
          fi
        fi

        ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild "''$@"

        if [ "''${SHLVL}" -eq 1 ] && [ "''${boot}" -eq 1 ] && [ "''${flake}" != "" ]; then
          echo "Running link check for flake: ''${flake}"
          ${pkgs.nix}/bin/nix run --offline "${self}#nixosConfigurations.''${flake}.config.system.linkCheck"
        fi
      ''
    );
  };
}
