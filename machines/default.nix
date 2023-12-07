{ inputs
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
            ../modules
            inputs.home-manager.nixosModules.home-manager
            inputs.musnix.nixosModules.musnix
            inputs.nur.nixosModules.nur
            inputs.sops-nix.nixosModules.sops
            (./. + "/${rootDir}" + "/${hostname}") # Each machine conf
            {
              home-manager = {
                useGlobalPkgs = true;
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
  recovery-gui = settings {
    hostname = "recovery";
    user = "nixos";
    wm = "gnome";
    scheme = "full";
  };
  recovery-cui = settings {
    hostname = "recovery";
    user = "nixos";
    wm = "";
    scheme = "small";
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
