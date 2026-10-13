# override: default.nixに記載の属性をオーバライドする
# overrideAttrs: default.nixに記載されていない属性も追加できる
# Package patch template
# (final: prev: {
#   package = prev.package.overrideAttrs (old: {
#   });
# })
# Unwrapped package patch template
# (final: prev: {
#   package = prev.package.unwrapped.override (old: {
#   });
# })
# 特殊なやつはcallPackageを呼ぶと良い
#  package = prev.callPackage "${prev.path}/path/to/package" {
#    buildGoModule = args: prev.buildGoModule (args // rec {
#    });
#  };
# pythonPackages patch template
# (final: prev: {
#   python3 =
#     let
#       pythonPackagesOverlays = (prev.pythonPackagesOverlays or [ ]) ++ [
#         (pfinal: pprev: {
#           package = pprev.package.overridePythonAttrs (old: {
#           });
#         })
#       ];
#       self = prev.python3.override {
#         inherit self;
#         packageOverrides = prev.lib.composeManyExtensions pythonPackagesOverlays;
#       };
#     in
#     self;
# })
# haskellPackages patch template
# (final: prev: {
#   haskellPackages = prev.haskellPackages.override {
#     overrides = hself: hsuper: {
#       # Can add/override packages here
#       package = prev.haskell.lib.doJailbreak hsuper.package;
#     };
#   };
# })
# (final: prev: {
#   embree = pkgs-stable.embree;
#   openimagedenoise = pkgs-stable.openimagedenoise;
#   blender = pkgs-stable.blender;
#   spotify = pkgs-stable.spotify;
# })
# Patch from https://github.com/NixOS/nixpkgs/pull/211600
{ nixpkgs-stable, inputs, ... }:
final: prev: {
  vivaldi = prev.vivaldi.override {
    commandLineArgs = "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo";
    proprietaryCodecs = true;
    enableWidevine = true;
  };
  python3 =
    let
      pythonPackagesOverlays = (prev.pythonPackagesOverlays or [ ]) ++ [
        (pfinal: pprev: {
          qtile = pprev.qtile.overrideAttrs (old: {
            patches = old.patches or [ ] ++ [
              ./qtile.patch
            ];
            disabledTests = old.disabledTests or [ ] ++ [
              "test_qtile_cmd"
            ];
          });
          qtile-extras = pprev.qtile-extras.overrideAttrs (old: {
            #NOTE: qtile-extras's test sometime failed.
            # high-cpu load during test is the cause, but I don't know how to fix it yet. So I just disable the test for now.
            doInstallCheck = false;
          });
        })
      ];
      self = prev.python3.override {
        inherit self;
        packageOverrides = prev.lib.composeManyExtensions pythonPackagesOverlays;
      };
    in
    self;
  python3Packages = final.python3.pkgs;
  zotero = prev.zotero.overrideAttrs (
    old:
    let
      inherit (builtins) replaceStrings;
      firefox-esr-bin-unwrapped =
        inputs.firefox.packages.${prev.stdenv.hostPlatform.system}.firefox-esr-bin.unwrapped.overrideAttrs
          (old: {
            installPhase = old.installPhase + ''
              cp $out/lib/firefox-bin-${old.version}/firefox-esr-bin $out/lib/firefox-bin-${old.version}/firefox-bin
            '';
          });

      firefox-esr-bin-darwin = prev.stdenvNoCC.mkDerivation (
        let
          extraFiles = { };

          pname = "Firefox";
          version = "140.17.0esr";
          url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/140.17.0esr/mac/en-US/Firefox%20140.17.0esr.dmg";
          sha256 = "e4684afe6f2d343ff7cbc019eeff383a930836e116a6407b92b0941b96494a97";
        in
        {

          inherit pname version;

          buildInputs = [ prev.undmg ];
          sourceRoot = ".";
          phases = [
            "unpackPhase"
            "installPhase"
          ];

          extraFilesPaths = prev.lib.lists.map (x: x.source) (prev.lib.attrsets.attrValues extraFiles);
          extraFilesTargets = prev.lib.attrsets.attrNames extraFiles;
          extraFilesRecursive = prev.lib.lists.map (x: if x.recursive or false then "true" else "false") (
            prev.lib.attrsets.attrValues extraFiles
          );

          installPhase = ''
            runHook preInstall

            mkdir -p $out/Applications
            cp -r Firefox*.app "$out/Applications/"

            if [ -n "$extraFilesPaths" ]; then
              extraFilesPathsArr=($extraFilesPaths)
              extraFilesTargetsArr=($extraFilesTargets)
              extraFilesRecursiveArr=($extraFilesRecursive)

              for i in "''${!extraFilesPathsArr[@]}"; do
                source_path="''${extraFilesPathsArr[$i]}"
                target_path_suffix="''${extraFilesTargetsArr[$i]}"
                recursive_copy="''${extraFilesRecursiveArr[$i]}"

                target_base_dir="$out/Applications/Firefox.app/Contents/Resources"
                full_target_path="$target_base_dir/$target_path_suffix"

                mkdir -p "$(dirname "$full_target_path")"

                if [[ "$recursive_copy" == "true" ]]; then
                  mkdir -p "$full_target_path"
                  echo "Copying directory $source_path to $full_target_path"
                  cp -R "$source_path/"* "$full_target_path/"
                else
                  echo "Copying file $source_path to $full_target_path"
                  cp "$source_path" "$full_target_path"
                fi
              done
            fi

            runHook postInstall
          '';

          src = prev.fetchurl {
            inherit url sha256;
          };

          meta = {
            description = "Mozilla Firefox, free web browser (binary package)";
            homepage = "http://www.mozilla.com/en-US/firefox/";
          };
        }
      );
    in
    {
      buildPhase =
        if prev.stdenv.hostPlatform.isLinux then
          (replaceStrings
            [ "${prev.firefox-esr-153-unwrapped}/lib/firefox" ]
            [ "${firefox-esr-bin-unwrapped}/lib/firefox-bin-${firefox-esr-bin-unwrapped.version}" ]
            old.buildPhase
          )
        else if prev.stdenv.hostPlatform.isDarwin then
          (replaceStrings
            [ "${prev.firefox-esr-153-unwrapped}/Applications/Firefox ESR.app" ]
            [ "${firefox-esr-bin-darwin}/Applications/Firefox.app" ]
            old.buildPhase
          )
        else
          old.buildPhase;
    }
  );
}
