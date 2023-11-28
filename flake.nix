{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flakes.url = "github:misumisumi/flakes";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nvimdots.url = "github:misumisumi/nvimdots";
    devshell = {
      url = "github:numtide/devshell";
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
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:misumisumi/nixos-common-config";
      # url = "path:/home/sumi/Templates/nix/nixos-common-config";
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

      overlay =
        { system }:
        let
          nixpkgs-stable = import inputs.nixpkgs-stable {
            inherit system;
            config = { allowUnfree = true; };
          };
        in
        {
          nixpkgs.overlays =
            [
              inputs.nur.overlay
              inputs.nixgl.overlay
              inputs.flakes.overlays.default
            ]
            ++ (import ./patches { inherit nixpkgs-stable; });
        };
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
            inherit inputs overlay stateVersion user;
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
            ];
            packages = with pkgs; [
              age
              sops
              ssh-to-age
            ];
          };
        };
      };
}

