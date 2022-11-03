{
  description = "General NixOS System Flake Configuration (w/o my private repository)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    nur.url = "github:nix-community/NUR";

    nixgl.url = "github:guibou/nixGL";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakes = {
      url = "github:Sumi-Sumi/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, flake-utils, nur, nixgl, home-manager, flakes}:
    let
      user = "sumi";
      stateVersion = "22.05";       # For Home Manager

      overlay = { inputs, nixpkgs, ... }: {
        nixpkgs.overlays = [
          nur.overlay
          nixgl.overlay
          flakes.overlays.default

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
        ];
      };
    in
    { 
      nixosConfigurations = (
        import ./default.nix {
          isGeneral = true;
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nur nixgl home-manager flakes;
        });
    };
}
