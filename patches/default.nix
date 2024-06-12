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
  xp-pentablet = prev.libsForQt5.callPackage ./xp-pen-drivers.nix { };
}

