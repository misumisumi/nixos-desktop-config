{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = {self, nixpkgs, flake-utils, nur}: 
    let
      user = "sumi";
      location = "$HOME/.dotfiles";
    in
    { 
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location;
        }
      );
    };
}
