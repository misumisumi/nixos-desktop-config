{ inputs
, overlay
, stateVersion
, user
, isGeneral ? false
, ...
}:
let
  lib = inputs.nixpkgs.lib;
  settings =
    { hostname
    , user
    , rootDir ? ""
    , system ? "x86_64-linux"
    , homeDirectory ? ""
    , scheme ? "minimal"
    , useNixOSWallpaper ? false
    , wm ? "qtile"
    ,
    }:
      with lib;
      nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostname user stateVersion wm; }; # specialArgs give some args to modules
        modules =
          [
            (overlay { inherit system; })
            inputs.nur.nixosModules.nur
            inputs.musnix.nixosModules.musnix
            inputs.sops-nix.nixosModules.sops
            ../modules

            (./. + "/${rootDir}" + "/${hostname}") # Each machine conf

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs hostname user stateVersion homeDirectory scheme useNixOSWallpaper wm;
              };
              home-manager.sharedModules = [
                inputs.flakes.nixosModules.for-hm
                inputs.nvimdots.nixosModules.nvimdots
                inputs.dotfiles.homeManagerModules.dotfiles
                inputs.sops-nix.homeManagerModules.sops
              ];
              home-manager.users."${user}" = {
                dotfilesActivation = true;
              };
            }
          ];
      };
in
if isGeneral
then {
  gnome = settings {
    hostname = "desktop";
    user = "general";
    rootDir = "general";
    wm = "gnome";
  };
  qtile = settings {
    hostname = "desktop";
    user = "general";
    rootDir = "general";
    wm = "qtile";
  };
  minimal = settings {
    hostname = "minimal";
    user = "general";
    rootDir = "general";
  };
}
else {
  mother = settings {
    hostname = "mother";
    scheme = "full";
    inherit user;
  };
  zephyrus =
    settings
      {
        hostname = "zephyrus";
        scheme = "full";
        inherit user;
      };
  stacia =
    settings
      {
        hostname = "stacia";
        scheme = "full";
        inherit user;
      };
}
