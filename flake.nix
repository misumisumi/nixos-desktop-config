{
  description = "Each my machine NixOS System Flake Configuration";
  nixConfig = {
    extra-substituters = [
      "https://misumisumi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flakes.url = "github:misumisumi/flakes";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/NUR";
    nvimdots = {
      url = "github:misumisumi/nvimdots";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixos-stable.follows = "nixpkgs-stable";
        disko.follows = "disko";
      };
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

  outputs = inputs @ { flake-parts, ... }: flake-parts.lib.mkFlake
    { inherit inputs; }
    {
      imports = [
        inputs.devshell.flakeModule
      ];
      flake = {
        nixosConfigurations = import ./machines {
          inherit (inputs.nixpkgs) lib;
          inherit inputs;
        };
      };
      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, system, ... }: {
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
            nixos-generators
            sops
            ssh-to-age
          ];
        };
      };
    };
}

