{ pkgs, ... }:
{
  cp-ssh-keys = pkgs.writeShellScriptBin "cp-ssh-keys" ''
    usage() {
      cat <<EOF # remove the space between << and EOF, this is due to web plugin issue
    Usage: ''$(
        basename "''${BASH_SOURCE[0]}"
      )  [-t] [-u] [-h] [-v]

      Deployment NixOS by colmena with workspace-specific variables

    Available options:

    -t, --target-dir       Target Directory
    -u, --username         Username under sops/users
    -h, --help             Print this help and exit
    -v, --verbose          Print script debug info
    EOF
      exit
    }

    cleanup() {
      trap - SIGINT SIGTERM ERR EXIT
      # script cleanup here
    }

    msg() {
      echo >&2 -e "''${1-}"
    }

    die() {
      local msg=''$1
      local code=''${2-1} # default exit status 1
      msg "''$msg"
      exit "''$code"
    }

    parse_params() {
      # default values of variables set from params
      target_dir=''${HOME}
      while (( $# > 0 )) do
        case "''${1-}" in
        -h | --help) usage ;;
        -v | --verbose) set -x ;;
        -t | --target-dir) shift
          target_dir=''${1-}
        ;;
        -u | --username) shift
          username=''${1-}
        ;;
        -?*) die "Unknown option: ''$1" ;;
        esac
        shift
      done

      return 0
    }

    parse_params "''$@"

    if [ -z "''${username}" ]; then
      die "Username is required. Use -u or --username to specify it."
    fi
    if [ -z "''${target_dir}" ]; then
      die "Target directory is required. Use -t or --target-dir to specify it."
    fi

    mkdir -p "''${target_dir}/.ssh"
    rsync --chmod=u+rw,go+r ${../sops/users}/''${username}/.ssh/* "''${target_dir}/.ssh/"
    ${pkgs.findutils}/bin/find "''${target_dir}/.ssh" -type f -name "id_*" -exec ${pkgs.sops}/bin/sops decrypt -i {} \;
    chmod 600 ''${target_dir}/.ssh/id_*
    chmod 644 ''${target_dir}/.ssh/id_*.pub
    chmod 700 ''${target_dir}/.ssh
  '';
}
