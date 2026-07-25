#WARNING: Temporary measures until nix-community/home-manager#9699 is merged
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types;

  cfg = config.programs.texlive;
in
{
  disabledModules = [
    "${inputs.home-manager}/modules/programs/texlive.nix"
  ];

  options = {
    programs.texlive = {
      enable = lib.mkEnableOption "TeX Live";

      package = mkOption {
        type = types.package;
        default = pkgs.texliveSmall;
        description = "TeX Live package set to use.";
      };

      extraPackages = mkOption {
        default = _ps: [ ];
        defaultText = "_ps: [ ];";
        example = lib.literalExpression ''
          ps: with ps; [ collection-fontsrecommended algorithms ];
        '';
        description = "Extra packages available to TeX Live.";
      };

      finalPackage = mkOption {
        type = types.package;
        description = "Resulting customized TeX Live package.";
        readOnly = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.finalPackage ];

    programs.texlive.finalPackage = cfg.package.withPackages cfg.extraPackages;
  };
}
