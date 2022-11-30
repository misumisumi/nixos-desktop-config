let
  dataDir = "var/lib/xppend1v2";
in
[
  (final: prev: {
    python3Packages = prev.python3Packages.override {
      overrides = pfinal: pprev: {
        dbus-next = pprev.dbus-next.overridePythonAttrs (old: { # dbus-nest have issue in test so remove some test.
          # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
          checkPhase = builtins.replaceStrings ["not test_peer_interface"] ["not test_peer_interface and not test_tcp_connection_with_forwarding"] old.checkPhase;
        });
      };
    };
  })
  (final: prev: {
    qtile = prev.qtile.unwrapped.override (old: {
      patches = old.patches ++ [
        ./fix-xcbq.patch
      ];
    });
  })
  (final: prev: {
    xp-pen-deco-01-v2-driver = prev.xp-pen-deco-01-v2-driver.overrideAttrs (old: {
      desktopItems = [ 
        (prev.makeDesktopItem {
          name = "xp-pen-driver";
          exec = "sudo xp-pen-driver /mini";
          icon = "pentablet";
          comment = "XPPen driver";
          desktopName = "xppentablet";
          categories = [ "Application" "Utility" ];
        })
      ];

      installPhase = ''
        runHook preInstall
        mkdir -p $out/{opt,bin,share}
        cp -r App/usr/lib/pentablet/{pentablet,resource.rcc,conf} $out/opt
        chmod +x $out/opt/pentablet
        cp -r App/lib $out/lib
        sed -i 's#usr/lib/pentablet#${dataDir}#g' $out/opt/pentablet

        cp -r $desktopItems/share/applications $out/share/applications
        cp -r App/usr/share/icons $out/share/icons
        runHook postInstall
      '';

      postFixup = ''
        makeWrapper $out/opt/pentablet $out/bin/xp-pen-driver \
        "''${qtWrapperArgs[@]}" \
          --run 'if [ "$EUID" -ne 0 ]; then echo "Please run as root."; exit 1; fi' \
          --run 'if [ ! -d /${dataDir} ]; then mkdir -p /${dataDir}; cp -r '$out'/opt/conf /${dataDir}; chmod u+w -R /${dataDir}; fi'
          '';

    });
  })
]
