{ inputs
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
        specialArgs = { inherit inputs hostname user useNixOSWallpaper wm; }; # specialArgs give some args to modules
        modules =
          [
            ../modules
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.musnix.nixosModules.musnix
            inputs.nur.nixosModules.nur
            inputs.sops-nix.nixosModules.sops
            (./. + "/${hostname}") # Each machine conf
            ({ config, ... }: {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs hostname user homeDirectory scheme useNixOSWallpaper wm;
                };
                sharedModules = [
                  inputs.dotfiles.homeManagerModules.dotfiles
                  inputs.flakes.homeManagerModules.default
                  inputs.nvimdots.homeManagerModules.nvimdots
                  inputs.sops-nix.homeManagerModules.sops
                  inputs.spicetify-nix.homeManagerModule
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
  test = settings {
    hostname = "mother";
    inherit user;
    scheme = "test";
  };
  liveimg-gui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "gnome";
    scheme = "small";
    useNixOSWallpaper = true;
  };
  liveimg-cui = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "";
    scheme = "small";
  };
  liveimg-iso = settings {
    hostname = "liveimg";
    user = "nixos";
    wm = "";
    scheme = "core";
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
