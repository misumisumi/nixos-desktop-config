{
  inputs,
  overlay,
  stateVersion,
  user,
  home-manager,
  nixgl,
  nixpkgs,
  nixpkgs-stable,
  nur,
  common-config,
  flakes,
  nvimdots,
  musnix ? null,
  private-config ? null,
  isGeneral ? false,
  ...
}:
# Multipul arguments
let
  lib = nixpkgs.lib;
  choiceSystem = x:
    if (x == "aegis")
    then "aarch64-linux"
    else "x86_64-linux";

  settings = {
    hostname,
    user,
    rootDir ? "",
    wm ? "gnome",
  }: let
    hostConf = ./. + (lib.optionalString (rootDir != "") "/${rootDir}") + "/${hostname}" + /home.nix;
    system = choiceSystem hostname;
    pkgs-stable = import nixpkgs-stable {
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
            (overlay {inherit nixpkgs pkgs-stable;})
            nur.nixosModules.nur
            musnix.nixosModules.musnix
            common-config.nixosModules.for-nixos
            # ../modules

            (./. + "/${rootDir}" + "/${hostname}") # Each machine conf

            home-manager.nixosModules.home-manager
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
                    flakes.nixosModules.for-hm
                    common-config.nixosModules.for-hm
                    nvimdots.nixosModules.for-hm
                  ]
                  ++ optionals (rootDir != "general") [private-config.nixosModules.for-hm];
              };
            }
          ]
          ++ (optional (rootDir != "general") private-config.nixosModules.for-nixos);
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