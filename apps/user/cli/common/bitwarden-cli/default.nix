{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mapAttrsToList
    filterAttrs
    hasPrefix
    removePrefix
    ;
  bw = "${pkgs.bitwarden-cli}/bin/bw";
  scripts = mapAttrsToList (
    n: credential:
    let
      name = removePrefix "bw/" n;
    in
    pkgs.writeShellScriptBin "bw-${name}" ''
      set -euo pipefail

      parse_params() {
        # default values of variables set from params
        count=0
        login=0
        unlock=0
        cmd_own=0
        while (( $# > 0 )) do
          count=''$((count + 1))
          case "''${1-}" in
            login)
              login=1
              cmd_own=1
              ;;
            unlock)
              unlock=1
              cmd_own=1
              ;;
          esac
          shift
        done

        count="''$((count + 1))"
        return 0
      }

      parse_params "''$@"

      BITWARDENCLI_APPDATA_DIR=${config.xdg.configHome}/Bitwarden\ CLI/${name}
      mkdir -p "''${BITWARDENCLI_APPDATA_DIR}"

      export BW_SESSION=""
      SESSIONKEY_FILE=''${BITWARDENCLI_APPDATA_DIR}/session
      if [ -f "''${SESSIONKEY_FILE}" ]; then
          BW_SESSION=$(cat "''${SESSIONKEY_FILE}")
      fi

      BW_STATUS=$(${bw} status | ${pkgs.jq}/bin/jq ".status" | ${pkgs.gnused}/bin/sed -e 's/.*"\(.*\)".*/\1/g')
      if [ "''${BW_STATUS}" == "locked" ]; then
          unlock=1
      elif [ "''${BW_STATUS}" == "unauthenticated" ]; then
          login=1
      fi

      export BW_PASSWORD=$(cat ${credential.path} | tail -n 1)
      BW_MAIL=$(cat ${credential.path} | head -n 1)
      if [ "''${login}" -eq 1 ]; then
        SESSIONKEY=$(${bw} login "''${BW_MAIL}" --passwordenv BW_PASSWORD)
        BW_SESSION=$(echo "''${SESSIONKEY}" | ${pkgs.gnugrep}/bin/grep export | ${pkgs.gnused}/bin/sed -e 's/.*"\(.*\)".*/\1/g')
        echo "$BW_SESSION" > "''${SESSIONKEY_FILE}"
        chmod 600 "''${SESSIONKEY_FILE}"
      elif [ "''${unlock}" -eq 1 ]; then
        SESSIONKEY=$(${bw} unlock --passwordenv BW_PASSWORD)
        BW_SESSION=$(echo "''${SESSIONKEY}" | ${pkgs.gnugrep}/bin/grep export | ${pkgs.gnused}/bin/sed -e 's/.*"\(.*\)".*/\1/g')
        echo "$BW_SESSION" > "''${SESSIONKEY_FILE}"
        chmod 600 "''${SESSIONKEY_FILE}"
      fi

      if [ "''${cmd_own}" -eq 0 ]; then
        ${bw} "''$@"
      fi
    ''
  ) (filterAttrs (n: _: hasPrefix "bw/" n) config.sops.secrets);
in
{
  home.packages = scripts;
}
