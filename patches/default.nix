{ pkgs-stable, ... }:
[
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
  (final: prev: {
    gmic = prev.gmic.overrideAttrs (old: rec {
      version = "3.2.0";
      src = prev.fetchFromGitHub {
        owner = "dtschump";
        repo = "gmic";
        rev = "v.${version}";
        hash = "sha256-lrIlzxXWqv046G5uRkBQnjvysaIcv+iDKxjuUEJWqcs=";
      };
      gmic_stdlib = prev.fetchurl {
        name = "gmic_stdlib.h";
        url = "http://gmic.eu/gmic_stdlib${prev.lib.replaceStrings ["."] [""] version}.h";
        hash = "sha256-kWHzA1Dk7F4IROq/gk+RJllry3BABMbssJxhkQ6Cp2M=";
      };
    });
  })
  (final: prev: {
    haskellPackages = prev.haskellPackages.override {
      overrides = hself: hsuper: {
        # Can add/override packages here
        thumbnail = prev.haskell.lib.doJailbreak hsuper.thumbnail;
      };
    };
  })

  (final: prev: {
    python3Packages = prev.python3Packages.override {
      overrides = pfinal: pprev: {
        qtile = pprev.qtile.overridePythonAttrs (old: {
          patches = old.patches ++ [
            ./fix-xcbq.patch
          ];
        });
      };
    };
  })
  # (final: prev: {
  #   qtile-unwrapped = prev.qtile-unwrapped.override (old: {
  #     patches = old.patches ++ [
  #       ./fix-xcbq.patch
  #     ];
  #   });
  # })
  (final: prev: {
    tmuxPlugins = prev.tmuxPlugins
      // {
      dracula = prev.tmuxPlugins.dracula.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "dracula";
          repo = "tmux";
          rev = "ffc6ef8efbe556fa908aee6615f0781348337faa";
          sha256 = "0a3vrp14pz0mpr7629grysmw6gf4hahvbiarafkl1nckll5yihyk";
        };
      });
    };
  })

  (final: prev:
    let
      dataDir = "var/lib/xppend1v2";
    in
    {
      xp-pen-driver = prev.xp-pen-deco-01-v2-driver.overrideAttrs (old: {
        desktopItems = [
          (prev.makeDesktopItem {
            name = "xp-pen-driver";
            exec = "xp-pen-driver-indicator";
            icon = "pentablet";
            comment = "XPPen driver";
            desktopName = "xppentablet";
            categories = [ "Application" "Utility" ];
          })
        ];
        run_script = prev.writeShellApplication {
          name = "xp-pen-driver";
          text = ''
            sudo sh -c "xp-pen-driver &"
          '';
        };
        indicator = prev.writeShellApplication {
          name = "xp-pen-driver-indicator";
          text = ''
            sudo sh -c "xp-pen-driver /mini &"
          '';
        };
        installPhase = ''
          runHook preInstall
          mkdir -p $out/{opt,bin,share}
          cp -r App/usr/lib/pentablet/{pentablet,resource.rcc,conf} $out/opt
          chmod +x $out/opt/pentablet
          cp -r App/lib $out/lib
          sed -i 's#usr/lib/pentablet#${dataDir}#g' $out/opt/pentablet
          cp -r $run_script/bin/* $out/bin
          cp -r $indicator/bin/* $out/bin
          sed -i "s#xp-pen-driver#$out/opt/xp-pen-driver#g" $out/bin/xp-pen-driver
          sed -i "s#xp-pen-driver#$out/opt/xp-pen-driver#g" $out/bin/xp-pen-driver-indicator

          cp -r App/usr/share/icons $out/share/icons
          cp -r $desktopItems/share/applications $out/share/applications
          runHook postInstall
        '';

        postFixup = ''
          makeWrapper $out/opt/pentablet $out/opt/xp-pen-driver \
          "''${qtWrapperArgs[@]}" \
            --run 'if [ ! -d /${dataDir} ]; then mkdir -p /${dataDir}; cp -r '$out'/opt/conf /${dataDir}; chmod u+w -R /${dataDir}; fi'
        '';

      });
    })
]

