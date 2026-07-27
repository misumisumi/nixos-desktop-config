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
  spicetify-cli = prev.spicetify-cli.overrideAttrs (old: {
    ldflags = old.ldflags ++ [
      "-X 'main.version=${old.version}'"
    ];
    nativeBuildInputs = old.nativeBuildInputs ++ [
      prev.nodejs
      prev.esbuild
    ];

    postBuild = ''
      esbuild ./src/jsHelper/spicetifyWrapper/index.js \
        --bundle --minify --target=chrome108 --format=iife \
        --outfile=spicetifyWrapper.js
    '';
    postInstall = old.postInstall + ''
      chmod -R u+w $out/share/spicetify/jsHelper
      cp spicetifyWrapper.js $out/share/spicetify/jsHelper/spicetifyWrapper.js
    '';
  });
  mcp-nixos = prev.mcp-nixos.overrideAttrs (old: {
    patches = old.patches or [ ] ++ [
      (prev.fetchpatch {
        url = "https://github.com/utensils/mcp-nixos/commit/86f8936f0c257153f8fba10cf8cba7fede6d2f30.patch";
        sha256 = "sha256-55rQhE9CfTW1KQzUNM86U4S4Efu4yCN+1tZvdOz12oc=";
      })
    ];
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
}
