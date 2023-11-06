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
    , wm ? "qtile"
    ,
    }:
    let
      hostConf = ./. + (lib.optionalString (rootDir != "") "/${rootDir}") + "/${hostname}" + /home.nix;
    in
    with lib;
    nixosSystem {
      inherit system;
      specialArgs = { inherit hostname inputs user stateVersion wm; }; # specialArgs give some args to modules
      modules =
        [
          ./configuration.nix # Common system conf
          (overlay { inherit system; })
          inputs.nur.nixosModules.nur
          inputs.musnix.nixosModules.musnix
          ../modules

          (./. + "/${rootDir}" + "/${hostname}") # Each machine conf

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit hostname user stateVersion wm;
              withExtra = true;
              withTmux = false;
              homeDirectory = "";
            };
            home-manager.users."${user}" = {
              # Common home conf + Each machine conf
              imports =
                [
                  (import hostConf)
                  ../modules/nixosWallpaper.nix
                  inputs.flakes.nixosModules.for-hm
                  # The settings for common-config will be loaded when it is imported.
                  # See `misumisumi/nixos-common-config` for configuration
                  inputs.common-config.nixosModules.home-manager
                  # inputs.common-config.nixosModules.tmux
                  inputs.nvimdots.nixosModules.nvimdots
                ]
                ++ optionals (rootDir != "general") [ inputs.private-config.nixosModules.for-hm ];
            };
          }
        ]
        ++ (optional (rootDir != "general") inputs.private-config.nixosModules.for-nixos);
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
    inherit user;
  };
  zephyrus =
    settings
      {
        hostname = "zephyrus";
        inherit user;
      };
  stacia =
    settings
      {
        hostname = "stacia";
        inherit user;
      };
}
