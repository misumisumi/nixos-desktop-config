#!/usr/bin/env bash
function logging() {
  echo "$(basename $0): $*"
}
function _check_cmd() {
  command -v "$1" &>/dev/null
}

logging "Start"

if ! _check_cmd tree-sitter; then
  if _check_cmd brew && [ -x "$(brew --prefix mise)/bin/mise" ]; then
    eval "$("$(brew --prefix mise)/bin/mise activate bash")"
  elif [ -x "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate bash)"
  fi
  if _check_cmd cargo && _check_cmd clang; then
    mise install conda:libclang
    LIBCLANG_PATH="$(mise where conda:libclang)"
    if [ -d "$LIBCLANG_PATH" ]; then
      mise install cargo:tree-sitter-cli
    fi
  fi
fi

NVIMDIR=${XDG_CONFIG_HOME:-$HOME/.config}/nvim

if [ -d "$NVIMDIR" ]; then
  cd "$NVIMDIR" || exit
  [ -f lazy-lock.json ] && git restore lazy-lock.json
  [ -f mason-lock.json ] && git restore mason-lock.json
fi

logging "Finish"
