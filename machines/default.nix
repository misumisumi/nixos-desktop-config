{ inputs
, overlay
, stateVersion
, user
, ...
}:
let
  inherit (inputs.nixpkgs) lib;
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
        specialArgs = { inherit inputs hostname user stateVersion useNixOSWallpaper wm; }; # specialArgs give some args to modules
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
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs hostname user stateVersion homeDirectory scheme useNixOSWallpaper wm;
                };
                sharedModules = [
                  inputs.flakes.nixosModules.for-hm
                  inputs.nvimdots.nixosModules.nvimdots
                  inputs.dotfiles.homeManagerModules.dotfiles
                  inputs.sops-nix.homeManagerModules.sops
                ];
                users."${user}" = {
                  dotfilesActivation = true;
                };
              };
            }
          ];
      };
in
{
  gnome = settings {
    hostname = "recovery";
    user = "nixos";
    wm = "gnome";
    scheme = "full";
  };
  tty-only = settings {
    hostname = "recovery";
    user = "nixos";
    wm = "";
    scheme = "minimal";
  };
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
