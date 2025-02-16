#!/usr/bin/env bash

[ -d ~/.ssh ] || mkdir ~/.ssh
[ -f ~/.ssh/id_ed25519.pub ] | ssh-keygen -t ed25519 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f ~/.ssh/id_ed25519
# [ -f ~/.ssh/id_rsa.pub ] | ssh-keygen -t rsa -b 4096 -N "" -C "$(whoami)@$(hostname)-$(date -I)" -f ~/.ssh/id_rsa
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
# chmod 600 ~/.ssh/id_rsa

# if executing go, run "go run"
if [ -f ~/.age-key.txt ]; then
  echo "Generate age key..."
  if command -v go &>/dev/null; then
    go run "github.com/Mic92/ssh-to-age/cmd/ssh-to-age@latest" -private-key -i ~/.ssh/id_ed25519 -o ~/.age-key.txt
  fi
fi
