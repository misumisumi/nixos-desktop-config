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
  opencode = prev.opencode.overrideAttrs (old: {
    node_modules = old.node_modules.overrideAttrs (_: {
      outputHash =
        if prev.stdenv.hostPlatform.isLinux then
          "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA="
        else if prev.stdenv.hostPlatform.isDarwin then
          "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc="
        else
          throw "Unsupported platform";
    });
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
          #NOTE: fastmcpのバージョンがv4になったら削除する
          fastmcp-slim = pprev.fastmcp-slim.override {
            mcp = pprev.mcp_1;
          };
        })
      ];
      self = prev.python3.override {
        inherit self;
        packageOverrides = prev.lib.composeManyExtensions pythonPackagesOverlays;
      };
    in
    self;
  python3Packages = final.python3.pkgs;
}
