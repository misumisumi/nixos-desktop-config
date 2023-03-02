{ inputs, overlay, stateVersion, user, nixpkgs, nixpkgs-stable, nur, nixgl, home-manager, flakes, musnix, nvim-config, private-conf ? null, isGeneral ? false, ... }: # Multipul arguments

let
  lib = nixpkgs.lib;
  choiceSystem = x: if (x == "aegis" || x == "ku-dere") then "aarch64-linux" else "x86_64-linux";

  settings = { hostname, user, rootDir, wm ? "gnome" }:
    let
      hostConf = ./. + "/${rootDir}" + "/${hostname}" + /home.nix;
      system = choiceSystem hostname;
      pkgs-stable = import nixpkgs-stable { inherit system; config = { allowUnfree = true; }; };
    in
    with lib; nixosSystem {
      inherit system;
      specialArgs = { inherit hostname inputs user stateVersion wm; }; # specialArgs give some args to modules
      modules = [
        ./configuration.nix # Common system conf
        (overlay { inherit inputs nixpkgs pkgs-stable; })
        nur.nixosModules.nur
        musnix.nixosModules.musnix
        ../modules

        (./. + "/${rootDir}" + "/${hostname}") # Each machine conf

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit hostname user stateVersion wm; };
          home-manager.users."${user}" = {
            # Common home conf + Each machine conf
            imports = [
              (import ../hm/hm.nix)
              (import hostConf)
              flakes.nixosModules.yaskkserv2
              nvim-config.nixosModules.nvim-config
            ]
            ++ optionals (rootDir != "general") (with private-conf.nixosModules; [ ssh_my_conf put_wallpapers ]);
          };
        }
      ] ++ (optional (rootDir != "general") private-conf.nixosModules.my-network);
    };
in
if isGeneral then
  {
    gnome = settings { hostname = "desktop"; user = "general"; rootDir = "general"; wm = "gnome"; };
    qtile = settings { hostname = "desktop"; user = "general"; rootDir = "general"; wm = "qtile"; };
    minimal = settings { hostname = "minimal"; user = "general"; rootDir = "general"; };
  }
else
  {
    mother = settings {
      hostname = "mother";
      rootDir = "ordinary"; inherit user;
    };
    zephyrus = settings
      { hostname = "zephyrus"; rootDir = "ordinary"; inherit user; };

    # metatron = settings { hostname = "metatron"; rootDir = "cardinal"; inherit user; };
    alice = settings { hostname = "alice"; rootDir = "cardinal"; inherit user; };
    strea = settings
      { hostname = "strea"; rootDir = "cardinal"; inherit user; };
    yui = settings
      { hostname = "yui"; rootDir = "cardinal"; inherit user; };
  }
