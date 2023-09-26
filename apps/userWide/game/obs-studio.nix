# Streaming/Recording app
{ lib
, hostname
, pkgs
, ...
}:
with lib; {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs;
        with pkgs.obs-studio-plugins;
        [
          looking-glass-obs
          obs-pipewire-audio-capture
          droidcam-obs-plugin
        ]
        ++ optional (hostname != "general") (
          obs-ndi.override {
            ndi = ndi.overrideAttrs (attrs: rec {
              src = fetchurl {
                name = "${attrs.pname}-${attrs.version}.tar.gz";
                url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/Install_NDI_SDK_v5_Linux.tar.gz";
                hash = "sha256-flxUaT1q7mtvHW1J9I1O/9coGr0hbZ/2Ab4tVa8S9/U=";
              };

              unpackPhase = ''unpackFile ${src}; echo y | ./${attrs.installerName}.sh; sourceRoot="NDI SDK for Linux";'';
              installPhase = ''
                mkdir $out
                mv bin/x86_64-linux-gnu $out/bin
                for i in $out/bin/*; do
                  patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$i"
                done
                patchelf --set-rpath "${avahi}/lib:${stdenv.cc.libc}/lib" $out/bin/ndi-record
                mv lib/x86_64-linux-gnu $out/lib
                for i in $out/lib/*; do
                  if [ -L "$i" ]; then continue; fi
                  patchelf --set-rpath "${avahi}/lib:${stdenv.cc.libc}/lib" "$i"
                done
                mv include examples $out/
                mkdir -p $out/share/doc/${attrs.pname}-${attrs.version}
                mv licenses $out/share/doc/${attrs.pname}-${attrs.version}/licenses
                mv documentation/* $out/share/doc/${attrs.pname}-${attrs.version}/
              '';
            });
          }
        );
    };
  };
}
