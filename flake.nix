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
    private-conf = {
      url = "git+ssh://git@github.com/Sumi-Sumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, nixpkgs, flake-utils, nur, nixgl, home-manager, flakes, private-conf}:
    let
      user = "sumi";
      stateVersion = "22.05";       # For Home Manager
      wm = "plasma5";               # only use for 'machines/general'
    in
    { 
      nixosConfigurations = (
        import ./machines {
          inherit (nixpkgs) lib;
          inherit inputs stateVersion user;
          inherit nixpkgs nur nixgl home-manager flakes private-conf;
        }
      );
    };
}
