{
  description = "General NixOS System Flake Configuration (w/o my private repository)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    flake-utils.url = "github:numtide/flake-utils";

    nur.url = "github:nix-community/NUR";

    nixgl.url = "github:guibou/nixGL";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    nur,
    nixgl,
    system-manager,
    home-manager,
    flakes,
    nvim-config,
  }: let
    user = "sumi";
    stateVersion = "22.11"; # For Home Manager

    overlay = {
      inputs,
      nixpkgs,
      ...
    }: {
      nixpkgs.overlays =
        [
          nur.overlay
          nixgl.overlay
          flakes.overlays.default
        ]
        ++ (import ../../patches);
    };
  in {
    systemConfigs.default = self.lib.makeSystemConfig {
      system = flake-utils.lib.system.x86_64-linux;
      modules = [
        ./default.nix
      ];
    };
  };
}
