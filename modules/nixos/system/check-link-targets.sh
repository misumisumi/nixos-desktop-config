# -*- mode: sh; sh-shell: bash -*-

function setupColors() {
  normalColor=""
  errorColor=""
  warnColor=""
  noteColor=""

  # Enable colors for terminals, and allow opting out.
  if [[ ! -v NO_COLOR && -t 1 ]]; then
    # See if it supports colors.
    local ncolors
    ncolors=$(tput colors 2>/dev/null || echo 0)

    if [[ -n "$ncolors" && "$ncolors" -ge 8 ]]; then
      normalColor="$(tput sgr0)"
      errorColor="$(tput bold)$(tput setaf 1)"
      warnColor="$(tput setaf 3)"
      noteColor="$(tput bold)$(tput setaf 6)"
    fi
  fi
}

setupColors

function errorEcho() {
  echo "${errorColor}$*${normalColor}"
}

function warnEcho() {
  echo "${warnColor}$*${normalColor}"
}

function noteEcho() {
  echo "${noteColor}$*${normalColor}"
}

noteEcho "Starting NixOS symlink check"

# A symbolic link whose target path matches this pattern will be
# considered part of a NixOS generation.
nixStorePathPattern="$(readlink -e @storeDir@)/*"
srcTargetPathes=(@srcTargetPathes@)

shift
for src_target in "${srcTargetPathes[@]}"; do
  # sourcePath=$(echo "$src_target" | cut -d'=' -f1 | sed -e 's|/\*||g')
  sourcePath=$(echo "$src_target" | cut -d'=' -f1 | sed -e 's|/\*||g')
  targetPath=/etc/"$(echo "$src_target" | cut -d'=' -f2)"

  if [[ -e "$targetPath" && ! "$(readlink -e "$targetPath")" == $nixStorePathPattern ]]; then
    # The target file already exists and it isn't a symlink owned by NixOS.
    if [[ -d "$sourcePath" ]]; then
      find "$sourcePath" -type f | while read -r sourceFile; do
        relativePath="${sourceFile#$sourcePath/}"
        targetFile="$targetPath/$relativePath"
        if [[ -e "$targetFile" && ! "$(readlink -e "$targetFile")" == $nixStorePathPattern ]]; then
          continue
        elif cmp -s "$sourceFile" "$targetFile"; then
          # First compare the files' content. If they're equal, we're fine.
          warnEcho "Existing file '$targetFile' is in the way of '$sourceFile', will be skipped since they are the same"
        else
          # Fail if nothing else works
          collisionErrors+=("Existing file '$targetFile' would be clobbered")
        fi
      done
    elif cmp -s "$sourcePath" "$targetPath"; then
      # First compare the files' content. If they're equal, we're fine.
      warnEcho "Existing file '$targetPath' is in the way of '$sourcePath', will be skipped since they are the same"
    else
      # Fail if nothing else works
      collisionErrors+=("Existing file '$targetPath' would be clobbered")
    fi
  fi
done

if [[ ${#collisionErrors[@]} -gt 0 ]]; then
  errorEcho "Remove missing files"

  for error in "${collisionErrors[@]}"; do
    errorEcho "$error"
  done
  exit 1
fi
