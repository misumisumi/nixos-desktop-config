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
#   python3Packages = prev.python3Packages.override {
#     overrides = pfinal: pprev: {
#       package = pprev.package.overridePythonAttrs (old: {
#       });
#     };
#   };
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
final: prev:
{
  # xp-pentablet-unwrapped = prev.libsForQt5.callPackage ./xp-pen-drivers { };
  haskellPackages = prev.haskellPackages.override {
    overrides = hself: hsuper: {
      # Can add/override packages here
      thumbnail = prev.haskell.lib.doJailbreak hsuper.thumbnail;
    };
  };
  # INFO: NixOS/nixpkgs#321738 がマージされるまでのパッチ
  spicetify-cli = prev.callPackage "${prev.path}/pkgs/by-name/sp/spicetify-cli/package.nix" {
    buildGoModule = args: prev.buildGoModule (args // rec {
      version = "2.36.13";

      src = prev.fetchFromGitHub {
        owner = "spicetify";
        repo = "cli";
        rev = "v${version}";
        hash = "sha256-0etyVzYL8F1GOAHEcpSfOoKe3GsGmAqVufVauqPDV1w=";
      };

      vendorHash = "sha256-po0ZrIXtyK0txK+eWGZDEIGMI1/cwyLVsGUVnTaHKP0=";
      postInstall = ''
        mv $out/bin/cli $out/bin/spicetify
        ln -s $out/bin/spicetify $out/bin/spicetify-cli
        cp -r ${src}/jsHelper $out/bin/jsHelper
        cp -r ${src}/CustomApps $out/bin/CustomApps
        cp -r ${src}/Extensions $out/bin/Extensions
        cp -r ${src}/Themes $out/bin/Themes
      '';
    });
  };
  xp-pentablet = prev.libsForQt5.callPackage ./xp-pen-drivers.nix { };
}

