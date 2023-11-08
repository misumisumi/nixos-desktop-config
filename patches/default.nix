{ nixpkgs-stable, ... }: [
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
    pythonPackagesOverlays = (prev.pythonPackagesOverlays or [ ]) ++ [
      (pfinal: pprev: {
        qtile = pprev.qtile.overridePythonAttrs (old:
          {
            version = "2023.09.20"; # qtile
            src = prev.fetchFromGitHub {
              owner = "qtile";
              repo = "qtile";
              rev = "45f249cddd89f782fa309a16b5ad653eab03b9c2";
              hash = "sha256-NZBPTvvt944j/rhoPKUQpbiQAuG9SFE2QP6yR7ISG0Q=";
            };
            prePatch = ''
              substituteInPlace libqtile/backend/wayland/cffi/build.py \
                --replace /usr/include/pixman-1 ${prev.pixman.outPath}/include \
                --replace /usr/include/libdrm ${prev.libdrm.dev.outPath}/include/libdrm
            '';
            buildInputs = with prev; [
              libinput
              wayland
              wlroots_0_16
              libxkbcommon
              libdrm
            ];
            propagatedBuildInputs =
              let
                _cairocffi = pprev.cairocffi.overridePythonAttrs (_: rec {
                  pname = "cairocffi";
                  version = "1.6.1";
                  src = prev.fetchPypi {
                    inherit pname version;
                    hash = "sha256-eOa75HNXZAxFPQvpKfpJzQXM4uEobz0qHKnL2n79uLc=";
                  };
                  format = "pyproject";
                  postPatch = "";
                  propagatedNativeBuildInputs = with prev.python3Packages; [ cffi flit-core ];
                });
                _xcffib = pfinal.xcffib.overrideAttrs (oldAttrs: rec {
                  version = "1.5.0";
                  patches = [ ];
                  src = oldAttrs.src.override {
                    inherit version;
                    hash = "sha256-qVyUZfL5e0/O3mBr0eCEB6Mt9xy3YP1Xv+U2d9tpGsw=";
                  };
                });
                _pywlroots =
                  let
                    pname = "pywlroots";
                    version = "0.16.4";
                  in
                  pprev.${pname}.overridePythonAttrs (old: {
                    inherit pname version;
                    buildInputs = with prev; [ libinput libxkbcommon pixman xorg.libxcb udev wayland wlroots_0_16 ];
                    src = prev.fetchPypi {
                      inherit pname version;
                      hash = "sha256-+1PILk14XoA/dINfoOQeeMSGBrfYX3pLA6eNdwtJkZE=";
                    };
                  });
              in
              with prev; with pprev; [
                _xcffib
                (_cairocffi.override { withXcffib = true; xcffib = _xcffib; })
                python-dateutil
                dbus-python
                dbus-next
                mpd2
                psutil
                pyxdg
                pygobject3
                pywayland
                _pywlroots
                xkbcommon
                pulseaudio
              ];
            patches =
              old.patches
                ++ [
                ./fix-xcbq.patch
              ];
          }
        );
      }
      )
    ];
  })
  (final: prev: { })
  (final: prev: {
    haskellPackages = prev.haskellPackages.override {
      overrides = hself: hsuper: {
        # Can add/override packages here
        thumbnail = prev.haskell.lib.doJailbreak hsuper.thumbnail;
      };
    };
  })
  (final: prev: {
    tmuxPlugins =
      prev.tmuxPlugins
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




















