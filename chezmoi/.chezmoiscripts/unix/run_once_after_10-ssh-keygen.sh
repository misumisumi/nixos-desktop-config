#!/usr/bin/env bash
function logging() {
  echo "$(basename $0): $*"
}

logging "Start"

[ -d ~/.ssh ] || mkdir "$HOME/.ssh" && chmod 700 ~/.ssh
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  logging "Generate ed25519 key"
  ssh-keygen -t ed25519 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f "$HOME/.ssh/id_ed25519"
  chmod 600 ~/.ssh/id_ed25519
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
  logging "Generate rsa key"
  ssh-keygen -t rsa -b 4096 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f "$HOME/.ssh/id_rsa"
  chmod 600 ~/.ssh/id_rsa
fi

# if executing go, run "go run"
AGE_KEY_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/sops/age/keys.txt"
if [ ! -f "${AGE_KEY_FILE}" ]; then
  logging "Generate age key..."
  if command -v go &>/dev/null; then
    mkdir -p "$(dirname ${AGE_KEY_FILE})"
    go run "github.com/Mic92/ssh-to-age/cmd/ssh-to-age@latest" -private-key -i ~/.ssh/id_ed25519 -o "${AGE_KEY_FILE}"
  fi
fi

logging "Finish"
