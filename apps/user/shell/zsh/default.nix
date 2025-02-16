#  Zsh conf
#  I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
#  When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
#  You can watch this solution at (machines/home.nix home.activation.myActivationAction)
{
  lib,
  config,
  pkgs,
  user,
  importChezmoiUserAppData,
  importFilesFromChezmoi,
  ...
}:
{
  home.packages = with pkgs; [ nix-zsh-completions ];
  xdg.configFile = importFilesFromChezmoi {
    chezmoiSrc = "dot_config/zsh-abbr";
    recursive = true;
  };
  programs = {
    zsh = {
      enable = true;

      inherit ((importChezmoiUserAppData user).zsh)
        extraFunctions
        extraModules
        extraOptions
        envExtra
        initExtraFirst
        initExtraBeforeCompInit
        initExtra
        localVariables
        ;

      autosuggestion.enable = false;
      enableCompletion = false;
      autocd = true;

      history = {
        ignorePatterns = (importChezmoiUserAppData user).shell.historyIgnore;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        saveNoDups = true;
        share = true;
        save = 10000;
        size = 15000;
      };
      zinit =
        let
          zinitConf = (importChezmoiUserAppData user).zsh.zinit;
        in
        {
          enable = true;
          enableAliases = false;
          promptTheme = {
            enable = false;
            theme = "romkatv/powerlevel10k";
            modifier = ''
              depth=1 atload'P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
              [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
              source "''${HOME}/.p10k.zsh"' light-mode \
            '';
          };
          inherit (zinitConf) plugins;
          prezto = {
            enable = true;
            inherit (zinitConf.prezto) pmodules pmodulesWithModifier;
          };
          initConfig =
            let
              init_fzf = lib.optionalString config.programs.fzf.enable ''
                # Binding keys for zsh-abbr
                if [[ $options[zle] = on ]]; then
                  eval "$(${pkgs.fzf}/bin/fzf --zsh)"
                fi
              '';
            in
            ''
              # The plugin will auto execute this zvm_after_init function
              function zvm_after_init() {
                  ${init_fzf}
              }
            '';
        };
      shellAliases = {
        nix = "noglob nix";
        nixos-rebuild = "noglob nixos-rebuild";
      };
    };
  };
}
