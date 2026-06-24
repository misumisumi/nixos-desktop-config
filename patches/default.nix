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
{ nixpkgs-stable, ... }:
final: prev: {
  vivaldi = prev.vivaldi.override {
    commandLineArgs = "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo";
    proprietaryCodecs = true;
    enableWidevine = true;
  };
  flameshot = prev.flameshot.overrideAttrs (old: {
    qtWrapperArgs = [ "--set QT_SCALE_FACTOR_ROUNDING_POLICY Round" ] ++ old.qtWrapperArgs or [ ];
  });
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
  github-copilot-cli = prev.github-copilot-cli.overrideAttrs (
    old:
    let
      arch =
        with prev.stdenv.hostPlatform;
        if isx86_64 then
          "x64"
        else if isAarch64 then
          "arm64"
        else
          throw "Unsupported arch: ${prev.stdenv.hostPlatform.system}";
      platform = if prev.stdenv.hostPlatform.isDarwin then "darwin-${arch}" else "linux-${arch}";
      version = "1.0.64";
    in
    {
      inherit version;
      src = prev.fetchurl {
        url = "https://github.com/github/copilot-cli/releases/download/v${version}/github-copilot-${version}-${platform}.tgz";
        hash =
          {
            "x86_64-darwin" = "sha256-DKp85sN0IuJyIHSLOCZa8uabOZtiEAVUennNlYr7nL0=";
            "aarch64-darwin" = "sha256-2JkfpBNV4MAJ2U2TgzOvJP4cwaGFDx58MbxmROX/8Sc=";
            "x86_64-linux" = "sha256-p2I4BHdW9wRLP8ns7wmuWBwUW2RGOuARgDtItMovxGA=";
            "aarch64-linux" = "sha256-xcFHefIgy0BQTnIbgwH48+VK2fYHhQf8wWBq9SixNeY=";
          }
          .${prev.stdenv.hostPlatform.system}
            or (throw "Unsupported system: ${prev.stdenv.hostPlatform.system}");
      };
    }
  );
}
