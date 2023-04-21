{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakes = {
      url = "github:misumisumi/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvimdots = {
      # url = "github:misumisumi/nvimdots";
      url = "github:misumisumi/nvimdots";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakes.follows = "flakes";
    };
    private-config = {
      url = "git+ssh://git@github.com/misumisumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    flake-utils,
    nur,
    nixgl,
    home-manager,
    flakes,
    musnix,
    nix-matlab,
    nvimdots,
    private-config,
  }: let
    user = "sumi";
    stateVersion = "23.05"; # For Home Manager

    overlay = {
      inputs,
      nixpkgs,
      pkgs-stable,
      ...
    }: {
      nixpkgs.overlays =
        [
          nur.overlay
          nixgl.overlay
          nix-matlab.overlay
          flakes.overlays.default
          private-config.overlays.default
        ]
        ++ (import ./patches {inherit pkgs-stable;});
    };
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit inputs overlay stateVersion user;
        inherit nixpkgs nixpkgs-stable nur nixgl home-manager flakes musnix nvimdots private-config;
      }
    );
    homeConfigurations = (
      import ./hm {
        inherit (nixpkgs) lib;
        inherit inputs overlay stateVersion user;
        inherit nixpkgs nixpkgs-stable nur nixgl home-manager flakes nvimdots private-config;
      }
    );
  };
}
