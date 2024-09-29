{
  self,
  inputs,
  pkgs,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.flakes.overlays.default
      inputs.nixgl.overlay
      inputs.nur.overlay
      self.overlays.default
    ];
  };
}
