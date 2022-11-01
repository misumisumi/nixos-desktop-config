# Home-manager configuration for general
{ inputs, stateVersion, nixpkgs, nur, nixgl, home-manager, flakes, user, private-conf ? null, ... }: # Multipul arguments
let
  choiceSystem = x: if ( x == "dummy" ) then "aarch64-linux" else "x86_64-linux";

  settings = { hostname, user }:
    let
      system = choiceSystem hostname;
      pkgs = nixpkgs.legacyPackages.${system};
    in
      home-manager.lib.hjomeManagerConfiguration {
        inherit pkgs;
        modules = [
          (overlay { inherit inputs nixpkgs; })
          nur.nixosModules.nur

          ./hm.nix
          ./${hostname}
        ];
      };
in
{
  arch = settings { hostname = "arch"; inherit user; };
  general = settings { hostname = "general"; user = "general"; };
}
