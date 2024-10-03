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
      scheme ? "minimal",
      colorTheme ? "tokyonight-moon",
      useNixOSWallpaper ? true,
      excludeShells ? [ ],
      wm ? "none",
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
          wm
          ;
      }; # specialArgs give some args to modules
      modules = [
        inputs.catppuccin.nixosModules.catppuccin
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        inputs.musnix.nixosModules.musnix
        inputs.nur.nixosModules.nur
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.vfio
        self.nixosModules.virtualisation
        self.nixosModules.xp-pentablet
        (./. + "/${hostname}") # Each machine conf
        (
          { config, ... }:
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit
                  inputs
                  hostname
                  user
                  homeDirectory
                  scheme
                  colorTheme
                  excludeShells
                  useNixOSWallpaper
                  wm
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
in
{
  liveimg-gui-qtile = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "full";
    colorTheme = "tokyonight-moon";
  };
  liveimg-gui-gnome = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "full";
    colorTheme = "tokyonight-moon";
  };
  liveimg-gui-iso = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "small";
    colorTheme = "tokyonight-moon";
  };
  liveimg-gui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "small";
    colorTheme = "tokyonight-moon";
  };
  liveimg-cui-iso = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "none";
    scheme = "core";
    colorTheme = "tokyonight-moon";
  };
  liveimg-cui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "none";
    scheme = "small";
    colorTheme = "tokyonight-moon";
  };
  mother = settings {
    hostname = "mother";
    scheme = "full";
    colorTheme = "tokyonight-moon";
    useNixOSWallpaper = false;
    wm = "qtile";
    inherit user;
  };
  zephyrus = settings {
    hostname = "zephyrus";
    scheme = "full";
    colorTheme = "tokyonight-moon";
    useNixOSWallpaper = false;
    wm = "qtile";
    inherit user;
  };
  stacia = settings {
    hostname = "stacia";
    scheme = "full";
    colorTheme = "tokyonight-moon";
    useNixOSWallpaper = false;
    wm = "qtile";
    inherit user;
  };
  soleus = settings {
    hostname = "soleus";
    user = "kobayashi";
    scheme = "small";
    colorTheme = "tokyonight-moon";
    wm = "gnome";
  };
}
