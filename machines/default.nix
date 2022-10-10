#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./machines  
#       ├─ default.nix *
#       ├─ configuration.nix
#       ├─ home.nix
#       └─ ./aegis OR ku-dere OR ./mother OR ./tsundere OR ./yandere OR ./vm OR ./zephyrus
#            ├─ ./default.nix
#            └─ ./home.nix
#
# aegis is Jetson Nano. ku-dere is Rasberry Pi 3B.
# aegis and ku-dere and yandere is server.

{ inputs, nixpkgs, home-manager, nur, user, location, ... }: # Multipul arguments

let
  choiceSystem = x: if ( x == "aegis" || x == "ku-dere" ) then "aarch64-linux" else "x86_64-linux";
  type = x: if ( x == "aegis" || x == "ku-dere" || x == "yandere") then "server" else "desktop";

  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;  # Allow proprietary software
  # };

  stateVersion = "22.05";

  settings = { hostname, inputs, nixpkgs, home-manager, nur, user, location, stateVersion }: nixpkgs.lib.nixosSystem {    # Common profile
    system = choiceSystem hostname;
    specialArgs = { inherit inputs user location stateVersion; }; # specialArgs give some args to modules
    modules = [
      nur.nixosModules.nur
      ./configuration.nix    # TZ and console settings and so on...
      (./. + "/${hostname}")

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user stateVersion; };
        home-manager.users."${user}" = {
          # Common and each machine configuration
          imports = [(import ./home.nix)] ++ [(import ./. + "/${hostname}" + /home.nix)];
        };
      }
    ];
  };
in
{
  aegis = settings { hostname="aegis"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  ku-dere = settings { hostname="ku-dere"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  mother = settings { hostname="mother"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  tsundere = settings { hostname="tsundere"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  yandere = settings { hostname="yandere"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  vm = settings { hostname="vm"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
  zephyrus = settings { hostname="zephyrus"; inherit inputs nixpkgs home-manager nur user location stateVersion; };
}
