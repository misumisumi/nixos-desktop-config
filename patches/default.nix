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
final: prev: {
  evince = prev.evince.overrideAttrs (old: rec {
    version = "48.0";
    src = prev.fetchurl {
      url = "mirror://gnome/sources/evince/${prev.lib.versions.major version}/evince-${version}.tar.xz";
      sha256 = "sha256-zS9lg1X6kHX9+eW0SqCvOn4JKMVWFOsQQrNhds9FESY=";
    };
  });
  xp-pentablet = prev.libsForQt5.callPackage ./xp-pen-drivers.nix { };
  pandoc-plantuml-filter = prev.pandoc-plantuml-filter.overridePythonAttrs (old: rec {
    version = "0.1.5";
    src = prev.fetchPypi {
      inherit (old) pname;
      inherit version;
      sha256 = "sha256-9qXeIZuCu44m9EoPCPL7MgEboEwN91OylLfbkwhkZYQ=";
    };
    pyproject = true;
    propagatedBuildInputs =
      with prev.python3Packages;
      old.propagatedBuildInputs
      ++ [
        setuptools
        setuptools-scm
      ];
    patchPhase = ''
      substituteInPlace pandoc_plantuml_filter.py --replace "os.environ.get(\"PLANTUML_BIN\", \"plantuml\")" "os.environ.get(\"PLANTUML_BIN\", \"${prev.plantuml}/bin/plantuml\")"
    '';
  });
  canon-cups-ufr2 = prev.callPackage ./canon-cups-ufr2.nix { };
}
