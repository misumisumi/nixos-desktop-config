let
  dataDir = "var/lib/xppend1v2";
in
[
  (final: prev: {
    python3Packages = prev.python3Packages.override {
      overrides = pfinal: pprev: {
        dbus-next = pprev.dbus-next.overridePythonAttrs (old: {
          # dbus-nest have issue in test so remove some test.
          # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
          checkPhase = builtins.replaceStrings [ "not test_peer_interface" ] [ "not test_peer_interface and not test_tcp_connection_with_forwarding" ] old.checkPhase;
        });
      };
    };
  })

  (final: prev: {
    python3Packages = prev.python3Packages.override {
      overrides = pfinal: pprev: {
        ephemeral-port-reserve = pprev.ephemeral-port-reserve.overridePythonAttrs (old: {
          pythonImportsCheck = "";
        });
      };
    };
  })

  (final: prev: {
    clisp = prev.clisp.override {
      # On newer readline8 fails as:
      #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
      #   does not have the required size or alignment
      readline = prev.readline6;
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
    unzip = prev.unzip.overrideAttrs (old: {
      patches = old.patches ++ [
        ./fix-unzip.patch
      ];
    });
  })

  (final: prev: {
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
