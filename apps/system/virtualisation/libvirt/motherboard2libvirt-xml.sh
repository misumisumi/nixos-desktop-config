#!/usr/bin/env bash
set -euo pipefail

# check running as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" >&2
  exit 1
fi

dmi_get() {
  local key="$1"
  local value
  value=$(dmidecode --string "$key" 2>/dev/null || :)
  if [[ -z "$value" ]]; then
    echo "Unknown"
  else
    echo "$value"
  fi
}

bios_vendor=$(dmi_get bios-vendor)
bios_version=$(dmi_get bios-version)
bios_date=$(dmi_get bios-release-date)
system_manufacturer=$(dmi_get system-manufacturer)
system_product=$(dmi_get system-product-name)
system_version=$(dmi_get system-version)
system_serial=$(dmi_get system-serial-number)
system_uuid=$(dmi_get system-uuid)
system_sku=$(dmi_get system-sku-number)
system_family=$(dmi_get system-family)
cat <<EOF
  <sysinfo type="smbios">
    <bios>
      <entry name="vendor">${bios_vendor}</entry>
      <entry name="version">${bios_version}</entry>
      <entry name="date">${bios_date}</entry>
    </bios>
    <system>
      <entry name="manufacturer">${system_manufacturer}</entry>
      <entry name="product">${system_product}</entry>
      <entry name="version">${system_version}</entry>
      <entry name="serial">${system_serial}</entry>
      <entry name="uuid">${system_uuid}</entry>
      <entry name="sku">${system_sku}</entry>
      <entry name="family">${system_family}</entry>
    </system>
  </sysinfo>
EOF

echo 'add <smbios mode="sysinfo"/> in <os> section'
