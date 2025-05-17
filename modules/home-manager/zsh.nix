{ lib, config, ... }:
with lib;
let
  cfg = config.programs.zsh;
in
{
  options = {
    programs.zsh = {
      extraOptions = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          List of extra zsh options.
        '';
      };
      extraFunctions = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          List of extra zsh functions to be installed.
        '';
      };
      extraModules = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          List of extra zsh modules to be installed.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      initContent = mkBefore ''
        # load extra zshoptions
        ${concatStringsSep "\n" (map (x: "setopt ${x}") cfg.extraOptions)}
        # load extra zshmodules
        zmodload ${concatStringsSep " " (map (x: "zsh/${x}") cfg.extraModules)}
        # load extra zshfunctions
        autoload -Uz ${concatStringsSep " " cfg.extraFunctions}
      '';
    };
  };
}
