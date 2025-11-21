# {{- $os := .chezmoi.os -}}
# {{- $osConfig := or (get . $os) dict -}}

# {{- $hostName := .chezmoi.hostname -}}
# {{- $hostConfig := or (get (or (get $osConfig "hosts") dict) $hostName) dict -}}
# {{- $hostPkgConfigs := or (get $hostConfig "packages") dict -}}

# {{- $userName := .chezmoi.username -}}
# {{- $userConfig := or (get (or (get $osConfig "users") dict) $userName) dict -}}
# {{- $userPkgConfigs := or (get $userConfig "packages") dict -}}

#!/usr/bin/env bash

function logging() {
  echo "$(basename "$0"): $*"
}

function install_node_package() {
  logging "Installing Node.js package: $1..."
  if ! command -v npm &>/dev/null; then
    logging "npm is not installed. Please install Node.js and npm first."
    exit 1
  fi
  NODE_PRE
  npm install "$1"
  logging "Node.js package '$1' installed successfully."
}

# Function to install a Python package
function install_python_package() {
  logging "Installing Python package: $1..."
  if ! command -v pip &>/dev/null; then
    logging "pip is not installed. Please install Python and pip first."
    exit 1
  fi
  VIRTUAL_ENV="${PKGDIR}/<pkg-name>"
  pip install "$1"
  logging "Python package '$1' installed successfully."
}

# Function to install a Go package
function install_go_package() {
  logging "Installing Go package: $1..."
  if ! command -v go &>/dev/null; then
    logging "Go is not installed. Please install Go first."
    exit 1
  fi
  go install "$1"
  logging "Go package '$1' installed successfully."
}

MCP_SERVERS_ROOT="${MCP_SERVERS_ROOT:-$HOME/mcp-servers}"
PKGDIR="${MCP_SERVERS_ROOT}/packages"
BINDIR="${MCP_SERVERS_ROOT}/bin"
