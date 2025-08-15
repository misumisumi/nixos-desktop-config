#!/usr/bin/env bash
function logging() {
  echo "$(basename $0): $*"
}

logging "Start"

NVIMDIR=${XDG_CONFIG_HOME:-$HOME/.config}/nvim

if [ -d "$NVIMDIR" ]; then
  cd "$NVIMDIR"
  [ -f lazy-lock.json ] && git restore lazy-lock.json
  [ -f mason-lock.json ] && git restore mason-lock.json
fi

logging "Finish"
