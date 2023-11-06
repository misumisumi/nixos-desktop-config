# Home-manager configuration for general
{ inputs
, overlay
, stateVersion
, ...
}:
let
  settings =
    { hostname
    , user
    , system ? "x86_64-linux"
    , withExtra ? false
    , withTmux ? false
    , withGui ? false
    , homeDirectory ? ""
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (inputs.nixpkgs) lib;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit hostname user stateVersion withExtra withTmux homeDirectory; };
      modules = [
        (overlay { inherit system; })
        inputs.nur.nixosModules.nur

        inputs.flakes.nixosModules.for-hm
        inputs.common-config.nixosModules.home-manager
        inputs.nvimdots.nixosModules.nvimdots
        ./nix-conf.nix
      ]; # ++ lib.optional withGui ./gui.nix;
    };
in
{
  y_univ = settings {
    hostname = "general";
    user = "kobayashi";
    homeDirectory = "/homex/kobayashi";
  };
}
