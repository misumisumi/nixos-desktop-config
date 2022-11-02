{ inputs, overlay, stateVersion, nixpkgs, nur, nixgl, home-manager, flakes, user, private-conf ? null, ... }: # Multipul arguments

let
  lib = nixpkgs.lib;
  choiceSystem = x: if ( x == "aegis" || x == "ku-dere" ) then "aarch64-linux" else "x86_64-linux";

  settings = { hostname, user, wm ? "plasma5" }:
  let
    hostConf = ./. + "/${hostname}" + /home.nix;
  in
    with lib; nixosSystem {
      system = choiceSystem hostname;
      specialArgs = { inherit hostname inputs user stateVersion wm; }; # specialArgs give some args to modules
      modules = [
        ./configuration.nix       # Common system conf
        (overlay { inherit inputs nixpkgs; })
        nur.nixosModules.nur

        flakes.nixosModules.asusd
        flakes.nixosModules.asus-notify
        flakes.nixosModules.supergfxd

        (./. + "/${hostname}")    # Each machine conf

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit hostname user stateVersion wm; };
          home-manager.users."${user}" = {
            imports = [(import ../hm/hm.nix)] ++ [(import hostConf)]  # Common home conf + Each machine conf
              ++ optional hostname != "general" [ pModules.my-network ];
          };
        }
      ] ++ optionals hostname != "general" [ pModules.ssh_my_conf pModules.put_wallpapers ];
    };
in
{
  # aegis = settings { hostname="aegis"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # ku-dere = settings { hostname="ku-dere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # mother = settings { hostname="mother"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # tsundere = settings { hostname="tsundere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # yandere = settings { hostname="yandere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # zephyrus = settings { hostname="zephyrus"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # general = settings { hostname="general"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  zephyrus = settings { hostname = "zephyrus"; inherit user; };
  plasma5 = settings { hostname = "general"; user = "general"; wm = "plasma5"; };
  qtile = settings { hostname = "general"; user = "general"; wm = "qtile"; };
}
