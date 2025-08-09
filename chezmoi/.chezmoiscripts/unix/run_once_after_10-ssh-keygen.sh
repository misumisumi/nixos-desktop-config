#!/usr/bin/env bash

[ -d ~/.ssh ] || mkdir "$HOME/.ssh" && chmod 700 ~/.ssh
[ -f ~/.ssh/id_ed25519.pub ] || ssh-keygen -t ed25519 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f "$HOME/.ssh/id_ed25519" && chmod 600 ~/.ssh/id_ed25519
[ -f ~/.ssh/id_rsa.pub ] || ssh-keygen -t rsa -b 4096 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f "$HOME/.ssh/id_rsa" && chmod 600 ~/.ssh/id_rsa

# if executing go, run "go run"
if [ ! -f ~/.age-key.txt ]; then
  echo "Generate age key..."
  if command -v go &>/dev/null; then
    mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/sops/age"
    go run "github.com/Mic92/ssh-to-age/cmd/ssh-to-age@latest" -private-key -i ~/.ssh/id_ed25519 -o "${XDG_CONFIG_HOME:-$HOME/.config}/sops/age/keys.txt"
  fi
fi
