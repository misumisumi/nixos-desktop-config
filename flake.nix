{
  description = "Each my machine NixOS System Flake Configuration";
  nixConfig = {
    extra-substituters = [
      "https://misumisumi.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixos-stable.follows = "nixpkgs-stable";
        disko.follows = "disko";
      };
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
    };

    flakes.url = "github:misumisumi/flakes";
    nvimdots = {
      url = "github:misumisumi/nvimdots/0.11";
      inputs = {
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      imports = [ inputs.devshell.flakeModule ];
      flake =
        let
          inherit (nixpkgs) lib;
        in
        {
          overlay = self.overlays.default;
          overlays.default =
            let
              nixpkgs-stable = import inputs.nixpkgs-stable {
                system = "x86_64-linux";
                config = {
                  allowUnfree = true;
                };
              };
            in
            import ./patches { inherit nixpkgs-stable; };
          homeManagerModules =
            let
              modulePath = ./modules/home-manager;
            in
            lib.mapAttrs' (
              f: _: lib.nameValuePair (lib.removeSuffix ".nix" f) (import (modulePath + "/${f}"))
            ) (builtins.readDir modulePath);
          nixosModules =
            let
              modulePath = ./modules/nixos;
            in
            lib.mapAttrs' (
              f: _: lib.nameValuePair (lib.removeSuffix ".nix" f) (import (modulePath + "/${f}"))
            ) (builtins.readDir modulePath);
          homeConfigurations = import ./machines/home-manager.nix {
            inherit (inputs.nixpkgs) lib;
            inherit inputs self;
          };
          nixosConfigurations = import ./machines {
            inherit (inputs.nixpkgs) lib;
            inherit inputs self;
          };
        };
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, system, ... }:
        {
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
              {
                help = "nixos-anywhere";
                name = "nixos-anywhere";
                command = ''
                  ${inputs.nixos-anywhere.packages.${system}.nixos-anywhere}/bin/nixos-anywhere ''${@}
                '';
              }
            ];
            packages = with pkgs; [
              age
              bashInteractive
              home-manager
              nixos-generators
              sops
              ssh-to-age
            ];
          };
        };
    };
}
