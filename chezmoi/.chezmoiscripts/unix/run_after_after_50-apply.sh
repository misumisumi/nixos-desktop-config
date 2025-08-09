#!/usr/bin/env bash

vivaldi_dir="${XDG_CONFIG_HOME:-$HOME/.config}/vivaldi"

if [ -d "${vivaldi_dir}" ]; then
  find "${vivaldi_dir}" -maxdepth 1 -type d -name "Default" -or -name "Profile *" | while read -r profile; do
    mv "${profile}/Preferences" "${profile}/Preferences.bak"
    jq -a -s '.[0] * .[1]' "${profile}/Preferences.bak" "${XDG_CONFIG_HOME}/vivaldi/CommonPreferences" >"${profile}/Preferences"
  done
fi
