{
  lib,
  stdenvNoCC,
  fetchGitHub,
  qemu,
  edk2,
  qemuVersion ? qemu.version,
  edk2Version ? edk2.version,
  ...
}:
let
  inherit (lib) majorMinor;
  qemuMajorMinor = majorMinor qemuVersion;
  edk2MajorMinor = majorMinor edk2Version;
in
stdenvNoCC.mkDerivation {
  name = "resit-eac-patch";
  src = fetchGitHub {
    owner = "Scrut1ny";
    repo = "AutoVirt";
    rev = "fb2cdedbfe7d994f73aef1e01db562c2466a3a8b";
    sha256 = "sha256-+l5n9sHhXoVh0mLZy7u+qj8kKpXoQG9n2iYl3r5s=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/{QEMU,EDK2}

    function cp_patches () {
    dir="$1"
    version="$2"
    outDir="$3"

    mkdir -p "''${outDir}"

    while read -r patch; do
        base=name=$(basename "$patch")
        lower="''${base,,}"
        cp_src="''${lower%%-*}.patch"
        cp "''${cp_src}" "''${outDir}"
    done < <(find patches/$dir -maxdepth 1 -type f -name "*''${version}.patch")
    }

    qemuPatchExist=$(find patches/QEMU -maxdepth 1 -type f -name "*${qemuVersion}.patch" | wc -l)
    if [ "$qemuPatchExist" -eq 0 ]; then
      qemuPatchExist=$(find patches/QEMU -maxdepth 1 -type f -name "*${qemuMajorMinor}*.patch" | wc -l)
      if [ "$qemuPatchExist" -eq 0 ]; then
        qemuPatchExist=$(find patches/QEMU/Archive -maxdepth 1 -type f -name "*${qemuMajorMinor}*.patch" | wc -l)
        if [ "$qemuPatchExist" -eq 0 ]; then
          echo "No patch found for QEMU version ${qemuVersion} or major.minor ${qemuMajorMinor}"
        else
          cp_patches "QEMU/Archive" "$qemuMajorMinor" "$out/QEMU"
        fi
      else
        cp_patches "QEMU" "$qemuMajorMinor" "$out/QEMU"
      fi
    else
      cp_patches "QEMU" "$qemuVersion" "$out/QEMU"
    fi

    edk2PatchExist=$(find patches/EDK2 -maxdepth 1 -type f -name "*${edk2Version}.patch" | wc -l)
    if [ "$edk2PatchExist" -eq 0 ]; then
      edk2PatchExist=$(find patches/EDK2 -maxdepth 1 -type f -name "*${edk2MajorMinor}*.patch" | wc -l)
      if [ "$edk2PatchExist" -eq 0 ]; then
        edk2PatchExist=$(find patches/EDK2/Archive -maxdepth 1 -type f -name "*${edk2MajorMinor}*.patch" | wc -l)
        if [ "$edk2PatchExist" -eq 0 ]; then
          echo "No patch found for EDK2 version ${edk2Version} or major.minor ${edk2MajorMinor}"
        else
          cp_patches "EDK2/Archive" "$edk2MajorMinor" "$out/EDK2"
        fi
      else
        cp_patches "EDK2" "$edk2MajorMinor" "$out/EDK2"
      fi
          else
      cp_patches "EDK2" "$edk2Version" "$out/EDK2"
          fi
  '';
}
