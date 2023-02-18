{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

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
    nvim-config = {
      url = "github:Sumi-Sumi/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakes.follows = "flakes";
    };
    private-conf = {
      url = "git+ssh://git@github.com/Sumi-Sumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, flake-utils, nur, nixgl, home-manager, flakes, nvim-config, private-conf }:
    let
      user = "sumi";
      stateVersion = "23.05";       # For Home Manager

      overlay = { inputs, nixpkgs, pkgs-stable, ... }: {
        nixpkgs.overlays = [
          nur.overlay
          nixgl.overlay
          flakes.overlays.default
          private-conf.overlays.default
        ] ++ (import ./patches { inherit pkgs-stable; });
      };
    in
    {
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nixpkgs-stable nur nixgl home-manager flakes nvim-config private-conf;
        }
      );
      homeConfigurations = (
        import ./hm {
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nixpkgs-stable nur nixgl home-manager flakes nvim-config private-conf;
        }
      );
    };
}
