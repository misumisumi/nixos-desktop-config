# Home-manager configuration for general
{ inputs
, overlay
, stateVersion
, ...
}:
let
  inherit (inputs.nixpkgs) lib;
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
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit hostname user stateVersion withExtra withTmux; };
      modules = [
        (overlay { inherit inputs; })
        inputs.nur.nixosModules.nur

        inputs.common-config.nixosModules.home-manager
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
