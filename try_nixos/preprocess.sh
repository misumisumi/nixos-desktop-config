#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
--run           Generate configs for general machine
--restore       Restore flake.nix
--lvm-only      Install only using LVM (Default LVM on LUKS)
--lvm-on-luks   Install using LVM-on-LUKS
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  RUN=0
  RESTORE=0
  LVMONLY=0
  LVMONLUKS=0

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --run) RUN=1 ;;
    --restore) RESTORE=1 ;; # example flag
    --lvm-only) LVMONLY=1 ;; # example flag
    --lvm-on-luks) LVMONLUKS=1 ;; # example flag
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "$@"
setup_colors

# script logic here
if [ ${RUN} -eq 1 ]; then
    patch ../flake.nix ./patch/flake.patch
    patch ../apps/desktop/media/obs-studio.nix ./patch/obs-studio.patch
    msg "- Please README for next step."
fi

if [ ${RESTORE} -eq 1 ]; then
    patch -R ../flake.nix ./patch/flake.patch
    patch -R ../apps/desktop/media/obs-studio.nix ./patch/obs-studio.patch
    msg "- restored"
fi

if [ ${LVMONLY} -eq 1 ]; then
    patch ../machines/general/hardware-configuration.nix ./patch/general-hardware-conf.patch
fi
if [ ${LVMONLUKS} -eq 1 ]; then
    patch -R ../machines/general/hardware-configuration.nix ./patch/general-hardware-conf.patch
fi
