{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flakes.url = "github:misumisumi/flakes";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nvimdots.url = "github:misumisumi/nvimdots";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:misumisumi/home-manager-config";
      # url = "path:/home/sumi/Templates/nix/home-manager-config";
      inputs = {
        flakes.follows = "flakes";
        home-manager.follows = "home-manager";
        nixgl.follows = "nixgl";
        nixpkgs-stable.follows = "nixpkgs-stable";
        nixpkgs.follows = "nixpkgs";
        nur.follows = "nur";
        nvimdots.follows = "nvimdots";
        sops-nix.follows = "sops-nix";
      };
    };
  };

  outputs = inputs @ { self, flake-parts, ... }:
    let
      user = "sumi";
      stateVersion = "23.11"; # For Home Manager
    in
    flake-parts.lib.mkFlake
      { inherit inputs; }
      {
        imports = [
          inputs.devshell.flakeModule
        ];
        flake = {
          nixConfig = {
            extra-substituters = [
              "https://misumisumi.cachix.org"
            ];
            extra-trusted-public-keys = [
              "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
            ];
          };
          nixosConfigurations = import ./machines {
            inherit (inputs.nixpkgs) lib;
            inherit inputs stateVersion user;
          };
        };
        systems = [ "x86_64-linux" ];
        perSystem = { config, pkgs, system, ... }: rec{
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ ];
            config.allowUnfree = true;
          };
          devshells.default = {
            commands = [
              {
                help = "update keys of sops secrets";
                name = "update-keys";
                command = ''
                  find sops/secrets -type f | xargs -I{} sops updatekeys --yes {}
                '';
              }
              {
                help = "disko";
                name = "disko";
                command = ''
                  ${inputs.disko.packages.${system}.disko}/bin/disko ''${@}
                '';
              }
            ];
            packages = with pkgs; [
              age
              nixos-generators
              sops
              ssh-to-age
            ];
          };
        };
      };
}

