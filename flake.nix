{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

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
    private-conf = {
      url = "git+ssh://git@github.com/Sumi-Sumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, nur, nixgl, home-manager, flakes, private-conf }:
    let
      user = "sumi";
      stateVersion = "23.05";       # For Home Manager

      overlay = { inputs, nixpkgs, ... }: {
        nixpkgs.overlays = [
          nur.overlay
          nixgl.overlay
          flakes.overlays.default
          private-conf.overlays.default
        ] ++ (import ./patches);
      };
    in
    {
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nur nixgl home-manager flakes private-conf;
        }
      );
      homeConfigurations = (
        import ./hm {
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nur nixgl home-manager flakes private-conf;
        }
      );
    };
}
