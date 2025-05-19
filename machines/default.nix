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
        inputs.home-manager.nixosModules.home-manager
        inputs.impermanence.nixosModules.impermanence
        inputs.musnix.nixosModules.musnix
        inputs.nur.modules.nixos.default
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.default
        (./. + "/${hostname}/system") # Each machine conf
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
                  homeDirectory
                  schemes
                  colorTheme
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
  ] ++ desktopSchemes;

  cliIsoSchemes = [
    "presets/small"
    "shell"
  ];
  guiIsoSchemes = [
    "presets/huge"
    "desktop/env/core/ime/fcitx5"
    "shell"
  ];
  guiLiveImgSchemes = [
    "presets/huge"
    "desktop/env/core/ime/fcitx5"
    "shell"
  ];
in
{
  liveimg-qtile = settings {
    hostname = "liveimg";
    user = "nixos";
    colorTheme = "tokyonight-moon";
    schemes = guiLiveImgSchemes ++ [ "desktop/env/qtile" ];
  };
  liveimg-gnome = settings {
    hostname = "liveimg";
    user = "nixos";
    colorTheme = "tokyonight-moon";
    schemes = guiLiveImgSchemes;
  };
  liveimg-gnome-iso = settings {
    colorTheme = "tokyonight-moon";
    hostname = "liveimg";
    schemes = guiIsoSchemes;
    user = "nixos";
  };
  liveimg-cli-iso = settings {
    colorTheme = "tokyonight-moon";
    hostname = "liveimg";
    schemes = cliIsoSchemes;
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
