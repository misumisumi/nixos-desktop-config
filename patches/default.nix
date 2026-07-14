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
  deskreen = prev.callPackage (
    {
      lib,
      stdenvNoCC,
      fetchurl,
      appimageTools,
    }:
    appimageTools.wrapType2 rec {
      pname = "deskreen";
      version = "3.2.16";

      src =
        let
          sources = {
            x86_64-linux = {
              arch = "x86_64";
              hash = "sha256-JcVKRINEWHJXzpdyiMSzx+cp/BzHBhrXRxYizQmkerI=";
            };
          };
        in
        fetchurl {
          url = "https://github.com/pavlobu/deskreen/releases/download/v${version}/deskreen-ce-${version}-${
            sources.${stdenvNoCC.hostPlatform.system}.arch
          }.AppImage";
          inherit (sources.${stdenvNoCC.hostPlatform.system}) hash;
        };
      extraInstallCommands =
        let
          contents = appimageTools.extractType2 { inherit pname version src; };
        in
        ''
          install -m 444 -D ${contents}/deskreen-ce.desktop $out/share/applications/deskreen-ce.desktop
          install -m 444 -D ${contents}/usr/share/icons/hicolor/256x256/apps/deskreen-ce.png \
            $out/share/icons/hicolor/512x512/apps/deskreen-ce.png
          substituteInPlace $out/share/applications/deskreen-ce.desktop \
            --replace-fail 'Exec=AppRun' 'Exec=deskreen'
        '';

      meta = {
        description = "Turn any device into a secondary screen for your computer";
        homepage = "https://deskreen.com";
        license = lib.licenses.agpl3Only;
        mainProgram = "deskreen";
        maintainers = with lib.maintainers; [
          leo248
        ];
        platforms = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      };
    }
  ) { };
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
      version = "1.0.65";
    in
    {
      inherit version;
      src = prev.fetchurl {
        url = "https://github.com/github/copilot-cli/releases/download/v${version}/github-copilot-${version}-${platform}.tgz";
        hash =
          {
            "x86_64-darwin" = "sha256-D72R1Vt/6eSg7INVYjPtC5W/6oPVzpVC1Tn4q831Wqs=";
            "aarch64-darwin" = "sha256-Ly/Tay3iOMzsipaWLTTh3HKBYwvq7Nu3yQpYrC39UPI=";
            "x86_64-linux" = "sha256-E8vo0HUyvw9U7cXbjeY7H9atxdMHHLMXcGgWEciuqK0=";
            "aarch64-linux" = "sha256-3l260k1Uw79owiBP2bhNfGgqkE35JN7zPSb8OXIpeuI=";
          }
          .${prev.stdenv.hostPlatform.system}
            or (throw "Unsupported system: ${prev.stdenv.hostPlatform.system}");
      };
    }
  );
}
