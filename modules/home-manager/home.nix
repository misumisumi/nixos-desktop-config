{
  config,
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  options = {
    home.linkCheck = lib.mkOption {
      internal = true;
      type = lib.types.package;
      description = "Command to run symlink checks.";
    };
  };
  config = {
    home.linkCheck =
      let
        mkCmd = res: ''
          _iNote "Runing %s" "${res.name}"
          ${res.data}
        '';
        sortedCommands = lib.hm.dag.topoSort {
          inherit (config.home.activation) checkLinkTargets;
        };
        checkCmds =
          if sortedCommands ? result then
            lib.concatStringsSep "\n" (map mkCmd sortedCommands.result)
          else
            abort ("Dependency cycle in check script: " + builtins.toJSON sortedCommands);
        checkBinPaths =
          lib.makeBinPath (
            with pkgs;
            [
              bash
              coreutils
              diffutils # For `cmp` and `diff`.
              findutils
              gettext
              gnugrep
              gnused
              ncurses # For `tput`.
            ]
          )
          + (
            # Add path of the Nix binaries, if a Nix package is configured, then
            # use that one, otherwise grab the path of the nix-env tool.
            if config.nix.enable && config.nix.package != null then
              ":${config.nix.package}/bin"
            else
              ":$(${pkgs.coreutils}/bin/dirname $(${pkgs.coreutils}/bin/readlink -m $(type -p nix-env)))"
          );
        checkScript = pkgs.writeShellScript "check-symlink" ''
          set -eu
          set -o pipefail

          cd $HOME

          export PATH="${checkBinPaths}"
          ${config.lib.bash.initHomeManagerLib}

          # The driver version indicates the behavior expected by the caller of
          # this script.
          #
          # - 0 : legacy behavior
          # - 1 : the script will not attempt to update the Home Manager Nix profile.
          hmDriverVersion=0

          while (( $# > 0 )); do
            opt="$1"
            shift

            case $opt in
              --driver-version)
                if (( $# == 0 )); then
                  errorEcho "$0: no driver version specified" >&2
                  exit 1
                elif (( 0 <= $1 && $1 <= 1 )); then
                  hmDriverVersion=$1
                else
                  errorEcho "$0: unexpected driver version $1" >&2
                  exit 1
                fi
                shift
                ;;
              *)
                _iError "%s: unknown option '%s'" "$0" "$opt" >&2
                exit 1
                ;;
            esac
          done
          unset opt

          ${builtins.readFile "${modulesPath}/lib-bash/activation-init.sh"}

          if [[ ! -v SKIP_SANITY_CHECKS ]]; then
            checkUsername ${lib.escapeShellArg config.home.username}
            checkHomeDirectory ${lib.escapeShellArg config.home.homeDirectory}
          fi

          ${checkCmds}
        '';
      in
      pkgs.runCommand "home-manager-link-check"
        {
          preferLocalBuild = true;
        }
        ''
          mkdir -p $out/bin

          cp ${checkScript} $out/link-checker

          ln -s $out/link-checker $out/bin/home-manager-link-check

          substituteInPlace $out/link-checker \
            --subst-var-by GENERATION_DIR $out \
            --replace-quiet "Starting Home Manager activation" "Starting Home Manager symlink check"

          ln -s ${config.home-files} $out/home-files
          ln -s ${config.home.path} $out/home-path
        '';
  };
}
