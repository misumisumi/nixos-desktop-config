{
  inputs,
  overlay,
  stateVersion,
  user,
  isGeneral ? false,
  ...
}:
# Multipul arguments
let
  lib = inputs.nixpkgs.lib;
  choiceSystem = x:
    if (x == "aegis")
    then "aarch64-linux"
    else "x86_64-linux";

  settings = {
    hostname,
    user,
    rootDir ? "",
    wm ? "qtile",
  }: let
    hostConf = ./. + (lib.optionalString (rootDir != "") "/${rootDir}") + "/${hostname}" + /home.nix;
    system = choiceSystem hostname;
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config = {allowUnfree = true;};
    };
  in
    with lib;
      nixosSystem {
        inherit system;
        specialArgs = {inherit hostname inputs user stateVersion wm;}; # specialArgs give some args to modules
        modules =
          [
            ./configuration.nix # Common system conf
            (overlay {
              inherit (inputs) nixpkgs;
              inherit pkgs-stable;
            })
            inputs.nur.nixosModules.nur
            inputs.musnix.nixosModules.musnix
            inputs.common-config.nixosModules.for-nixos
            # ../modules

            (./. + "/${rootDir}" + "/${hostname}") # Each machine conf

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit hostname user stateVersion wm;};
              home-manager.users."${user}" = {
                # Common home conf + Each machine conf
                imports =
                  [
                    (import ../hm/hm.nix)
                    (import hostConf)
                    ../modules/nixosWallpaper.nix
                    inputs.flakes.nixosModules.for-hm
                    inputs.common-config.nixosModules.for-hm
                    inputs.nvimdots.nixosModules.for-hm
                  ]
                  ++ optionals (rootDir != "general") [inputs.private-config.nixosModules.for-hm];
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