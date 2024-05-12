{ self
, inputs
, ...
}:
let
  inherit (inputs.nixpkgs) lib;
  user = "sumi";
  settings =
    { hostname
    , user
    , system ? "x86_64-linux"
    , homeDirectory ? ""
    , scheme ? "minimal"
    , useNixOSWallpaper ? false
    , wm ? "qtile"
    }:
      with lib;
      nixosSystem {
        inherit system;
        specialArgs = { inherit self inputs hostname user useNixOSWallpaper wm; }; # specialArgs give some args to modules
        modules =
          [
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.musnix.nixosModules.musnix
            inputs.nur.nixosModules.nur
            inputs.sops-nix.nixosModules.sops
            self.nixosModules.vfio
            self.nixosModules.virtualisation
            self.nixosModules.xp-pentablet
            (./. + "/${hostname}") # Each machine conf
            ({ config, ... }: {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs hostname user homeDirectory scheme useNixOSWallpaper wm;
                };
                sharedModules = [
                  inputs.flakes.homeManagerModules.default
                  inputs.nvimdots.homeManagerModules.nvimdots
                  inputs.sops-nix.homeManagerModules.sops
                  inputs.spicetify-nix.homeManagerModule
                  self.homeManagerModules.dotfiles
                  self.homeManagerModules.zinit
                ];
                users."${user}" = {
                  dotfilesActivation = true;
                  home.stateVersion = config.system.stateVersion;
                };
              };
            })
          ];
      };
in
{
  liveimg-gui-full = settings {
    hostname = "liveimg";
    user = "nixos";
    scheme = "full";
    useNixOSWallpaper = true;
  };
  liveimg-gui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "small";
    useNixOSWallpaper = true;
  };
  liveimg-cui-iso = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "";
    scheme = "core";
  };
  liveimg-cui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "";
    scheme = "small";
  };
  mother = settings {
    hostname = "mother";
    scheme = "full";
    inherit user;
  };
  zephyrus = settings {
    hostname = "zephyrus";
    scheme = "full";
    inherit user;
  };
  stacia = settings {
    hostname = "stacia";
    scheme = "full";
    inherit user;
  };
  soleus = settings {
    hostname = "soleus";
    user = "kobayashi";
    scheme = "small";
    useNixOSWallpaper = true;
    wm = "gnome";
  };
}
