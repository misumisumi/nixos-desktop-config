{ config, ... }:
let
  inherit (config.lib.ndchm.chezmoi) importTOMLFromChezmoi;
in
{
  programs =
    let
      starshipCmd = "${config.home.profileDirectory}/bin/starship";
    in
    {
      starship = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
        settings =
          (importTOMLFromChezmoi ".chezmoitemplates/starship/starship.toml")
          // (importTOMLFromChezmoi ".chezmoitemplates/starship/starship_modules.toml");
      };
      # "Do not activate on tty console"
      bash.initExtra = ''
        if [[ $TERM != "dumb" && $TERM != "linux" ]]; then
          eval "$(${starshipCmd} init bash --print-full-init)"
        fi
      '';
      zsh = {
        initContent = ''
          if [[ $TERM != "dumb" && $TERM != "linux" ]]; then
            eval "$(${starshipCmd} init zsh)"
          fi
        '';
      };
    };
}
