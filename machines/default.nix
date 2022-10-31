{ inputs, stateVersion, nixpkgs, nur, nixgl, home-manager, flakes, user, private-conf ? null, ... }: # Multipul arguments

let
  choiceSystem = x: if ( x == "aegis" || x == "ku-dere" ) then "aarch64-linux" else "x86_64-linux";
  type = x: if ( x == "aegis" || x == "ku-dere" || x == "yandere") then "server" else "desktop";
  overlay = { inputs, nixpkgs, ... }: {
    nixpkgs.overlays = [
      nur.overlay
      nixgl.overlay
      flakes.overlays.default
      (final: prev: {
          python3Packages = prev.python3Packages.override {
            overrides = pfinal: pprev: {
              dbus-next = pprev.dbus-next.overridePythonAttrs (old: { # dbus-nest have issue in test so remove some test.
                # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
                checkPhase = builtins.replaceStrings ["not test_peer_interface"] ["not test_peer_interface and not test_tcp_connection_with_forwarding"] old.checkPhase;
              });
            };
          };
        })
    ];
  };

  settings = {hostname, user, wm ? "plasma5"}:
  let
    hostConf = ./. + "/${hostname}" + /home.nix;
    pModules = if hostname != "general" then private-conf.nixosModules else null;
    extra-modules = if hostname != "general" then [ pModules.lab-network ] else [];
    extra-hm-modules = if hostname != "general" then [ pModules.ssh_my_conf pModules.put_wallpapers ] else [];
  in
    nixpkgs.lib.nixosSystem {
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
            imports = [(import ./home.nix)] ++ [(import hostConf)]  # Common home conf + Each machine conf
              ++ extra-hm-modules;
          };
        }
      ] ++ extra-modules;
    };
in
{
  # aegis = settings { hostname="aegis"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # ku-dere = settings { hostname="ku-dere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # mother = settings { hostname="mother"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # tsundere = settings { hostname="tsundere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # yandere = settings { hostname="yandere"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # vm = settings { hostname="vm"; inherit inputs nixpkgs home-manager overlay nur user stateVersion; };
  # zephyrus = settings { hostname="zephyrus"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  # general = settings { hostname="general"; inherit inputs nixpkgs overlay home-manager nur user stateVersion; };
  zephyrus = settings { hostname = "zephyrus"; inherit user; };
  general = settings { hostname = "zephyrus"; inherit user; };
}
