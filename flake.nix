let
  stateVersion = "22.05";       # For Homa Manager
  channelVersion = "unstable";  # For nixpkgs channel
in
{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = 
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-${channelVersion}";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = inputs @ {self, nixpkgs, flake-utils, home-manager, nur}: 
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
