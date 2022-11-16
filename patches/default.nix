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
]
