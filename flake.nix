{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    lxd-nixos = {
      url = "git+https://codeberg.org/adamcstephens/lxd-nixos";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.nixpkgs-2211.follows = "nixpkgs-stable";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
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

    common-config.url = "github:misumisumi/nixos-common-config";
    nvimdots.url = "github:misumisumi/nvimdots";
    flakes = {
      url = "github:misumisumi/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    private-config = {
      url = "git+ssh://git@github.com/misumisumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {
    self,
    flake-utils,
    home-manager,
    lxd-nixos,
    musnix,
    nix-matlab,
    nixgl,
    nixpkgs,
    nixpkgs-stable,
    nur,
    common-config,
    nvimdots,
    flakes,
    private-config,
  }: let
    user = "sumi";
    stateVersion = "23.05"; # For Home Manager

    overlay = {
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
      }
    );
    # homeConfigurations = (
    #   import ./hm {
    #     inherit (nixpkgs) lib;
    #     inherit inputs overlay stateVersion user;
    #     inherit nixpkgs nixpkgs-stable nur nixgl home-manager flakes nvimdots private-config;
    #   }
    # );
  };
}