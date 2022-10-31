{
  description = "Each my machine NixOS System Flake Configuration";

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
      stateVersion = "22.05";       # For Homa Manager
    in
    { 
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs stateVersion nixpkgs nur nixgl home-manager flakes user;
        }
      );
    };
}
