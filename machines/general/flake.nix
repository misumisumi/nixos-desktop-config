{
  description = "General NixOS System Flake Configuration (w/o my private repository)";

  inputs = {
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

    nvimdots = {
      url = "github:Sumi-Sumi/nvimdots";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakes.follows = "flakes";
    };
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, nur, nixgl, home-manager, flakes, nvimdots }:
    let
      user = "sumi";
      stateVersion = "22.11";       # For Home Manager

      overlay = { inputs, nixpkgs, ... }: {
        nixpkgs.overlays = [
          nur.overlay
          nixgl.overlay
          flakes.overlays.default
        ] ++ (import ../../patches);
      };
    in
    {
      nixosConfigurations = (
        import ../default.nix {
          isGeneral = true;
          inherit (nixpkgs) lib;
          inherit inputs overlay stateVersion user;
          inherit nixpkgs nur nixgl home-manager flakes nvimdots;
        }
      );
    };
}
