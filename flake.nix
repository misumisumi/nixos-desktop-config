{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = 
    let
      channelVersion = "unstable";  # For nixpkgs channel
    in
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
      stateVersion = "22.05";       # For Homa Manager
    in
    { 
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user stateVersion;
        }
      );
    };
}
