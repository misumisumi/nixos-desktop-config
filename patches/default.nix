[
  (final: prev: {
    python3Packages = prev.python3Packages.override {
      overrides = pfinal: pprev: {
        dbus-next = pprev.dbus-next.overridePythonAttrs (old: { # dbus-nest have issue in test so remove some test.
          # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
          checkPhase = builtins.replaceStrings ["not test_peer_interface"] ["not test_peer_interface and not test_tcp_connection_with_forwarding"] old.checkPhase;
        });
        qtile = pprev.qtile.overrideAttrs (old: {
          patches = old.patches ++ [
            ./fix-xcbq.patch
          ];
        });
      };
    };
  })
  # (final: prev: {
  #     python3Packages = prev.python3Packages.override {
  #       overrides = pfinal: pprev: {
  #         qtile = pprev.qtile.overridePythonAttrs (old: { # dbus-nest have issue in test so remove some test.
  #           patches = old.patches ++ [
  #             ./fix-monitor.patch
  #           ];
  #           patchPhase = ''
  #             ls ./
  #             exit 1
  #           '';

  #         });
  #       };
  #     };
  #   })
  # (final: prev: {
  #   qtile = prev.qtile.overrideAttrs (old: {
  #     passthru.unwrapped = {
  #       patches = old.passthru.unwrapped.patches ++ [
  #         ./fix-monitor.patch
  #       ];
  #     };
  #   });
  #  })
  # (final: prev: rec {
  #   pythonOverrides = pfinal: pprev: {
  #     qtile = pprev.qtile.overridePythonAttrs (old: {
  #       patches = final.patches ++ [
  #         ./fix-monitor.patch
  #       ];
  #     });
  #   };
  #   python3 = prev.python3.override {
  #     packageOverrides = final.pythonOverrides;
  #   };
  # })
  #  })
]
