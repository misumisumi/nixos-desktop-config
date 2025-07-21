{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.xsession.windowManager.qtile;
in
{
  options = {
    xsession.windowManager.qtile = {
      enable = mkEnableOption "qtile window manager";
      package = mkOption {
        type = types.nullOr types.package;
        default = pkgs.qtile-unwrapped;
        description = ''
          The qtile package to use.
        '';
      };
      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = ''
          Extra packages to be installed with qtile.
        '';
      };
      finalPackage = mkOption {
        type = types.package;
        readOnly = true;
        description = "Resulting customized qtile package.";
      };
      config = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = literalExpression ''
          pkgs.writeText "config.py" '''
          from libqtile import bar, layout, qtile, widget
          from libqtile.config import Click, Drag, Group, Key, Match, Screen
          from libqtile.lazy import lazy
          from libqtile.utils import guess_terminal

          mod = "mod4"
          terminal = guess_terminal()
          ...
          '''
        '';
        description = ''
          The configuration file to be used for qtile. This must be
          an absolute path or `null` in which case
          {file}`${config.xdg.configHome}/qtile/config.py` will not be managed
          by Home Manager.
        '';
      };
      configSource = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = literalExpression ./conf;
        description = ''
          The configuration dir to be used for qtile. This must be
          an absolute path or `null` in which case
          {file}`${config.xdg.configHome}/qtile` will not be managed
          by Home Manager.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    xdg.configFile = {
      "qtile/config.py" = {
        enable = cfg.config != null;
        source = cfg.config;
      };
      qtile = {
        enable = cfg.configSource != null;
        source = cfg.configSource;
        target = "qtile";
        recursive = true;
      };
    };
    xsession.windowManager = {
      qtile = {
        finalPackage = cfg.package.override {
          inherit (cfg) extraPackages;
        };
      };
      command = ''
        ${cfg.finalPackage}/bin/qtile start -b x11
      '';
    };
  };
}
