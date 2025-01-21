# This is home-manager module
# Prezto modules setting write to programs.zsh.prezto.<modules> or initExtra
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with types;
let
  cfg = config.programs.zsh.zinit;
  strListOrSingleton = coercedTo (either (listOf str) str) toList (listOf str);
  toZinitSyntax = x: intersperse " \\\n  " x;
  toPZTM = x: intersperse " \\\n  " (map (y: "PZTM::" + y) x);

  zinitPromptModules = submodule {
    options = {
      enable = mkEnableOption ''
        set prompt theme
      '';
      theme = mkOption {
        type = str;
        default = "";
        example = "romkatv/powerlevel10k";
        description = "Prompt theme";
      };
      modifier = mkOption {
        type = str;
        default = "";
        example = "depth'1'";
        description = "Ice Modifiers";
      };
    };
  };

  zinitPreztoModules = submodule {
    options = {
      enable = mkEnableOption ''
        load prezto modules from zinit
      '';
      pmodules = mkOption {
        type = listOf str;
        default = [
          "environment"
          "terminal"
        ];
        example = ''
          [
            "environment"
            "terminal"
          ];
        '';
        description = ''
          prezto modules only have 'init.zh'. Like 'environment', 'terminal'.
          see https://github.com/sorin-ionescu/prezto/tree/master/modules .
        '';
      };
      pmodulesWithModifier = mkOption {
        type = attrsOf strListOrSingleton;
        default = { };
        example = literalExpression ''
          {
            "wait'0a' lucid" = [
              "directory"
              "spectrum"
            ];
          }
        '';
        description = ''
          prezto modules load with external modifier. e.g. with ice modifier, need external modules. Like history, completion.
          format is <modules> = <zinit modifier>
          see https://github.com/sorin-ionescu/prezto/tree/master/modules .
        '';
      };
    };
  };

  zinitModules = submodule {
    options = {
      enable = mkEnableOption ''
        Flexible zsh plugins manager
      '';
      zinitHome = mkOption {
        type = path;
        default = "${config.home.homeDirectory}/.zinit";
        defaultText = "~/.zinit";
        apply = toString;
        description = "Path to zinit home directory.";
      };
      enableAliases = mkOption {
        type = bool;
        default = true;
        description = "Enable aliases";
      };
      promptTheme = mkOption {
        type = zinitPromptModules;
        default = { };
        description = "Options to configure prompt theme";
      };
      plugins = mkOption {
        type = attrsOf strListOrSingleton;
        default = { };
        example = literalExpression ''
          {
            "<modifier>" = [ "repo_a/plugin_a" "repo_b/plugin_b opts" ];
            "as'null' lucid sbin wait'1'" = [ "Fakerr/git-recall" "arzzen/git-quick-stats make'install'" ]
          }
        '';
        description = ''
          "Load rule and list of zinit plugins"
        '';
      };
      prezto = mkOption {
        type = zinitPreztoModules;
        default = { };
        description = "Options to configure prezto.";
      };
      initConfig = mkOption {
        type = str;
        default = "";
        description = ''
          config before loading plugins
        '';
      };
      extraConfig = mkOption {
        type = str;
        default = "";
        description = ''
          config for plugins
        '';
      };
    };
  };
in
{
  options = {
    programs.zsh = {
      zinit = mkOption {
        type = zinitModules;
        default = { };
        description = "Options to configure zinit.";
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zinit
      subversion
    ];

    programs.zsh.prezto.pmodules = mkIf (
      cfg.prezto.enable && (cfg.prezto.pmodules != [ ] || cfg.prezto.pmodulesWithModifier)
    ) (mkOrder 1200 [ ]);
    programs.zsh.initExtraBeforeCompInit = ''
      declare -A ZINIT
      ZINIT_HOME=${cfg.zinitHome}
      ZINIT[HOME_DIR]=''${ZINIT_HOME}
      ZINIT[NO_ALIASES]=${if cfg.enableAliases then "0" else "1"}
      [[ -r ''${ZINIT_HOME} ]] || mkdir -p ''${ZINIT_HOME}
      source "${pkgs.zinit}/share/zinit/zinit.zsh"&>/dev/null
      ln -sf "${pkgs.zinit}/share/zsh/site-functions/_zinit" ''${ZINIT_HOME}/completions
      (( ''${+_comps} )) && _comps[zinit]="${pkgs.zinit}/share/zsh/site-functions/_zinit"

      ${optionalString cfg.promptTheme.enable "zinit ${cfg.promptTheme.modifier} for ${cfg.promptTheme.theme}"}

      ${cfg.initConfig}

      ${optionalString (cfg.prezto.pmodules != [ ]) ''
        # zinit wait lucid for \
        zinit for \
          ${concatStrings (toPZTM cfg.prezto.pmodules)}
      ''}

      ${optionalString (cfg.prezto.pmodulesWithModifier != [ ]) ''
        ${concatStrings (
          toZinitSyntax (
            mapAttrsToList (
              modifier: modules: "zinit ${modifier} for \\\n ${concatStrings (toPZTM modules)}"
            ) cfg.prezto.pmodulesWithModifier
          )
        )}
      ''}

      ${optionalString (cfg.plugins != { }) ''
        ${concatMapStrings (x: x + "\n") (
          mapAttrsToList (
            modifier: plugins: "zinit ${modifier} for \\\n  ${concatStrings (toZinitSyntax plugins)}"
          ) cfg.plugins
        )}
      ''}
      ${cfg.extraConfig}
    '';
  };
}
