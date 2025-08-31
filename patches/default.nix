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
  canon-cups-ufr2 = prev.callPackage ./canon-cups-ufr2.nix { };
  xp-pentablet = prev.libsForQt5.callPackage ./xp-pen-drivers.nix { };
  vivaldi =
    (prev.vivaldi.override {
      commandLineArgs = "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo";
    }).overrideAttrs
      (old: {
        postInstall = ''
          rm $out/opt/vivaldi/libvulkan.so.1
          ln -s -t $out/opt/vivaldi "${prev.lib.getLib prev.vulkan-loader}/lib/libvulkan.so.1"
        '';
      });
  moralerspace = prev.moralerspace.overrideAttrs (old: rec {
    version = "2.0.0";
    src = prev.fetchzip {
      url = "https://github.com/yuru7/moralerspace/releases/download/v${version}/Moralerspace_v${version}.zip";
      hash = "sha256-RWpJt59Yvt/nhu6xeyR3eJKRaw+477ZXAPztt7Clt7Q=";
    };
  });
  moralerspace-hw = prev.moralerspace-hw.overrideAttrs (old: rec {
    version = "2.0.0";
    src = prev.fetchzip {
      url = "https://github.com/yuru7/moralerspace/releases/download/v${version}/MoralerspaceHW_v${version}.zip";
      hash = "sha256-gd195o0acZL8AhGvcLLQYxd1VWvUYjpVRMOT5D7zDME=";
    };
  });
  switcheroo-control = prev.switcheroo-control.overridePythonAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs ++ [ prev.wrapGAppsNoGuiHook ];
    dontWrapGApps = true;
    preFixup = ''
      makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
    '';
  });
  qtile-unwrapped = prev.qtile-unwrapped.overrideAttrs (old: {
    patches = old.patches ++ [
      ./qtile.patch
    ];
  });
  inherit (nixpkgs-stable) carla;
}
