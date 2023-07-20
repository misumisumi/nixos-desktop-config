# Home-manager configuration for general
{
  inputs,
  overlay,
  stateVersion,
  user,
  ...
}: let
  choiceSystem = x:
    if (x == "dummy")
    then "aarch64-linux"
    else "x86_64-linux";

  settings = {
    hostname,
    user,
  }: let
    system = choiceSystem hostname;
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit hostname user stateVersion;};
      modules = [
        (overlay {inherit inputs;})
        inputs.nur.nixosModules.nur

        ./hm.nix
        ./${hostname}
      ];
    };
in {
  arch = settings {
    hostname = "arch";
    inherit user;
  };
  general = settings {
    hostname = "general";
    user = "general";
  };
}
