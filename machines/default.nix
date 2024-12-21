{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  user = "sumi";
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
        inputs.musnix.nixosModules.musnix
        inputs.nur.modules.nixos.default
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.default
        (./. + "/${hostname}") # Each machine conf
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
                inputs.catppuccin.homeManagerModules.catppuccin
                inputs.flakes.homeManagerModules.default
                inputs.nvimdots.homeManagerModules.nvimdots
                inputs.sops-nix.homeManagerModules.sops
                inputs.spicetify-nix.homeManagerModules.default
                self.homeManagerModules.default
              ];
              users."${user}" = {
                imports =
                  lib.optional (lib.pathExists ../users/${user}) ../users/${user}
                  ++ lib.optional (lib.pathExists ./${hostname}/home.nix) ./${hostname}/home.nix;
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
    hostname = "liveimg";
    user = "nixos";
    colorTheme = "tokyonight-moon";
    schemes = guiIsoSchemes;
  };
  liveimg-cli-iso = settings {
    hostname = "liveimg";
    user = "nixos";
    colorTheme = "tokyonight-moon";
    schemes = cliIsoSchemes;
  };

  mother = settings {
    hostname = "mother";
    colorTheme = "tokyonight-moon";
    schemes = desktopSchemes;
    useNixOSWallpaper = false;
    inherit user;
  };
  zephyrus = settings {
    hostname = "zephyrus";
    colorTheme = "tokyonight-moon";
    schemes = laptopSchemes;
    useNixOSWallpaper = false;
    inherit user;
  };
  stacia = settings {
    hostname = "stacia";
    colorTheme = "tokyonight-moon";
    schemes = desktopSchemes;
    useNixOSWallpaper = false;
    inherit user;
  };
  soleus =
    let
      schemes = [
        "presets/huge"
        "desktop/env/core/ime/fcitx5"
        "shell"
      ];
    in
    settings {
      hostname = "soleus";
      user = "kobayashi";
      colorTheme = "tokyonight-moon";
      inherit schemes;
    };
}
