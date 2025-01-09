#!/usr/bin/env bash

# update Nvidia App
nvAppInstrallerUrl=$(wget --quiet -O - https://www.nvidia.com/en-us/software/nvidia-app | grep -Eo "https://us.download.nvidia.com/nvapp/client/[0-9]+.[0-9]+.[0-9]+.[0-9]+/NVIDIA_app_v[0-9.]+.exe" | head -n1)
nvAppVersion=$(echo $nvAppInstrallerUrl | grep -Eo "[0-9]+.[0-9]+.[0-9]+.[0-9]+" | head -n1)

wget --quiet -O NVIDIA_app.exe "${nvAppInstrallerUrl}"
nvAppSha256=$(sha256sum NVIDIA_app.exe | awk '{print toupper($1)}')

nvAppInstallerYaml=chezmoi/dot_local/share/winget/manifests/n/Nvidia/App/Nvidia.App.installer.yaml
nvAppLocaleYaml=chezmoi/dot_local/share/winget/manifests/n/Nvidia/App/Nvidia.App.locale.en-US.yaml
nvAppPkgYaml=chezmoi/dot_local/share/winget/manifests/n/Nvidia/App/Nvidia.App.yaml

sed -i -E "s/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/$nvAppVersion/g" "$nvAppInstallerYaml"
sed -i -E 's#(InstallerUrl:).*#\1 '"${nvAppInstrallerUrl}"'#g' "$nvAppInstallerYaml"
sed -i -E "s#(InstallerSha256:).*#\1 ${nvAppSha256}#g" "$nvAppInstallerYaml"
sed -i -E "s/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/${nvAppVersion}/g" "$nvAppLocaleYaml"
sed -i -E "s/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/${nvAppVersion}/g" "$nvAppPkgYaml"

rm NVIDIA_app.exe

# update OpenVR-SpaceCalibrator
OVRSCVersion=$(gh release list --exclude-drafts --exclude-pre-releases -L 1 --repo "hyblocker/OpenVR-SpaceCalibrator" --json "tagName" -q ".[].tagName")
OVRSCInstrallerUrl=$(gh release view ${OVRSCVersion} --repo "hyblocker/OpenVR-SpaceCalibrator" --json "assets" --jq ".assets[0].url")

wget --quiet -O OVRSC.exe "${nvAppInstrallerUrl}"
OVRSCSha256=$(sha256sum OVRSC.exe | awk '{print toupper($1)}')

OVRSCInstallerYaml=chezmoi/dot_local/share/winget/manifests/h/hyblocker/OpenVR-SpaceCalibrator/hyblocker.OpenVR-SpaceCalibrator.installer.yaml
OVRSCLocaleYaml=chezmoi/dot_local/share/winget/manifests/h/hyblocker/OpenVR-SpaceCalibrator/hyblocker.OpenVR-SpaceCalibrator.locale.en-US.yaml
OVRSCPkgYaml=./chezmoi/dot_local/share/winget/manifests/h/hyblocker/OpenVR-SpaceCalibrator/hyblocker.OpenVR-SpaceCalibrator.yaml

sed -i -E 's#(InstallerUrl:).*#\1 '"${OVRSCInstrallerUrl}"'#g' "$OVRSCInstallerYaml"
sed -i -E "s#(InstallerSha256:).*#\1 ${OVRSCSha256}#g" "$OVRSCInstallerYaml"
sed -i -E 's#(PackageVersion:).*#\1 '"${OVRSCVersion}"'#g' "$OVRSCInstallerYaml"
sed -i -E 's#(PackageVersion:).*#\1 '"${OVRSCVersion}"'#g' "$OVRSCLocaleYaml"
sed -i -E 's#(PackageVersion:).*#\1 '"${OVRSCVersion}"'#g' "$OVRSCPkgYaml"

rm OVRSC.exe
