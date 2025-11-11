{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  settings =
    {
      hostname,
      user,
      system ? "x86_64-linux",
      homeDirectory ? "",
      schemes ? [ ],
      colorTheme ? null,
      useNixOSWallpaper ? true,
    }:
    lib.nixosSystem {
      inherit system;
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
        inputs.catppuccin.nixosModules.catppuccin
        inputs.disko.nixosModules.disko
        inputs.flakes.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.impermanence.nixosModules.impermanence
        inputs.musnix.nixosModules.musnix
        inputs.nur.modules.nixos.default
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.default
        (./. + "/${if (lib.match "(liveimg)-.*" hostname != null) then "liveimg" else hostname}/system") # Each machine conf
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
                  homeDirectory
                  schemes
                  system
                  useNixOSWallpaper
                  ;
              };
              sharedModules = [
                inputs.catppuccin.homeModules.catppuccin
                inputs.flakes.homeManagerModules.default
                inputs.impermanence.homeManagerModules.impermanence
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
                home.stateVersion = config.system.stateVersion;
              };
            };
          }
        )
      ];
    };

  desktopSchemes = [
    "desktop/env/qtile"
    "presets/full"
    "shell"
  ];

  laptopSchemes = [
    "desktop/laptop"
  ]
  ++ desktopSchemes;

  minimalIsoSchemes = [
    "presets/small"
    "shell/bash"
    "shell/starship"
  ];
  gnomeIsoSchemes = [
    "desktop/env/core/ime/fcitx5"
    "desktop/theme"
    "desktop/tool/browser"
    "desktop/tool/utils"
    "presets/small"
    "shell/bash"
    "shell/starship"
  ];
in
{
  liveimg-gnome-iso = settings {
    colorTheme = "tokyonight-moon";
    hostname = "liveimg-gnome-iso";
    schemes = gnomeIsoSchemes;
    user = "nixos";
  };
  liveimg-minimal-iso = settings {
    colorTheme = "tokyonight-moon";
    hostname = "liveimg-minimal-iso";
    schemes = minimalIsoSchemes;
    user = "nixos";
  };

  mother = settings {
    colorTheme = "tokyonight-moon";
    hostname = "mother";
    schemes = desktopSchemes;
    useNixOSWallpaper = false;
    user = "sumi";
  };
  zephyrus = settings {
    colorTheme = "tokyonight-moon";
    hostname = "zephyrus";
    schemes = laptopSchemes;
    useNixOSWallpaper = false;
    user = "sumi";
  };
  stacia = settings {
    colorTheme = "tokyonight-moon";
    hostname = "stacia";
    schemes = desktopSchemes;
    useNixOSWallpaper = false;
    user = "sumi";
  };
}
