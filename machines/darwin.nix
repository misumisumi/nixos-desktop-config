{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  settings =
    {
      hostname,
      user,
      system ? "aarch64-darwin",
      schemes ? [ ],
      colorTheme ? null,
      useNixOSWallpaper ? false,
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          self
          colorTheme
          inputs
          hostname
          user
          useNixOSWallpaper
          ;
      }; # specialArgs give some args to modules
      modules = [
        inputs.home-manager.darwinModules.home-manager
        inputs.nur.modules.darwin.default
        inputs.sops-nix.darwinModules.sops
        (./. + "/${hostname}/system") # Each machine conf
        (
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              xcodes
            ];
            system.stateVersion = 6;
            nix = {
              package = pkgs.nixVersions.latest;
              checkConfig = true;
              settings = {
                substituters = [
                  "https://misumisumi.cachix.org"
                  "https://nix-community.cachix.org"
                ];
                trusted-public-keys = [
                  "misumisumi.cachix.org-1:f+5BKpIhAG+00yTSoyG/ihgCibcPuJrfQL3M9qw1REY="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                ];
                trusted-users = [
                  "root"
                  "${user}"
                ];
              };
              extraOptions = ''
                keep-outputs = true
                keep-derivations = true
                experimental-features = flakes nix-command
              '';
              gc = {
                automatic = true;
                interval = [
                  {
                    Weekday = 7;
                  }
                ];
                options = "--delete-older-than 7d";
              };
              optimise.automatic = true;
            };
            nixpkgs = {
              overlays = [
                inputs.nur.overlays.default
                inputs.flakes.overlays.default
              ];
              hostPlatform = {
                inherit system;
              };
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [
                  "libxml2-2.13.8"
                ];
              };
            };
          }
        )
        (
          { config, ... }:
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit
                  self
                  inputs
                  hostname
                  user
                  colorTheme
                  schemes
                  system
                  useNixOSWallpaper
                  ;
              };
              sharedModules = [
                inputs.catppuccin.homeModules.catppuccin
                inputs.flakes.homeManagerModules.default
                inputs.nvimdots.homeManagerModules.default
                inputs.sops-nix.homeManagerModules.sops
                inputs.spicetify-nix.homeManagerModules.default
                self.homeManagerModules.default
              ];
              users."${user}" = {
                imports =
                  lib.optional (lib.pathExists ../users/${user}) ../users/${user}
                  ++ lib.optional (lib.pathExists ./${hostname}/home) ./${hostname}/home;
                dotfilesActivation = true;
                home.stateVersion = config.system.nixpkgsRelease;
              };
            };
          }
        )
      ];
    };
in
{
  work = settings {
    colorTheme = "tokyonight-moon";
    hostname = "work";
    schemes = [
      "presets/medium"
      "shell"
    ];
    user = "kobayashis1033";
  };
}
