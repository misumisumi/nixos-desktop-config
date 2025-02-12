#!/usr/bin/env bash
cd "$(git rev-parse --show-toplevel)" || exit 1

# tmux.conf convert from nix to chezmoi
echo "tmux.conf convert from nix to chezmoi"

TMUXCONF="$XDG_CONFIG_HOME/tmux/tmux.conf"
CHEZMOI_TMUXCONF="chezmoi/dot_config/tmux/tmux.conf"
[ ! -d "$(dirname "$CHEZMOI_TMUXCONF")" ] && mkdir -p "$(dirname "$CHEZMOI_TMUXCONF")"
cp "$TMUXCONF" "$CHEZMOI_TMUXCONF"
chmod +w "$CHEZMOI_TMUXCONF"

TMUX_PLUGINS_LIST_URL="https://raw.githubusercontent.com/tmux-plugins/list/refs/heads/master/README.md"
TMUX_PLUGINS_LIST=$(curl -s "$TMUX_PLUGINS_LIST_URL" | grep -oP "\(https://github.com.*?\)" | sed -E "s%\(https://github.com/(.*)/(.*)\)%\1/\2%g")

grep -n -E 'run-shell.*tmux-plugins' "$TMUXCONF" | while read -r line; do
  n=$(echo "$line" | cut -d: -f1)
  plugin=$(echo "$line" | cut -d: -f2 | cut -d" " -f2 | cut -d"/" -f7)

  if [ "$plugin" == "tilish" ]; then
    sed -i -E "${n} s%run-shell.*%set -g @plugin 'jabirali/tmux-tilish'%g" "$CHEZMOI_TMUXCONF"
    continue
  elif [ "$plugin" == "tmux-fzf" ]; then
    sed -i -E "${n} s%run-shell.*%set -g @plugin 'sainnhe/tmux-fzf'%g" "$CHEZMOI_TMUXCONF"
    continue
  fi

  plugin_repo=$(echo "$TMUX_PLUGINS_LIST" | grep "$plugin")
  if [ -z "$plugin_repo" ]; then
    echo "plugin_repo not found: $plugin"
  else
    sed -i -E "${n} s%run-shell.*%set -g @plugin \'${plugin_repo}\'%g" "$CHEZMOI_TMUXCONF"
  fi
done

# add tpm that is tmux plugin manager
sed '1 a set -g @plugin "tmux-plugins/tpm"' -i "$CHEZMOI_TMUXCONF"
echo "run ~/.tmux/plugins/tpm/tpm" >>"$CHEZMOI_TMUXCONF"

if ! grep -q "/nix/store" "$CHEZMOI_TMUXCONF"; then
  echo "Success: tmux.conf convert from nix to chezmoi"
else
  echo "Error: tmux.conf convert from nix to chezmoi"
  exit 1
fi
