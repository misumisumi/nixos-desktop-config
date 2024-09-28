{
  config,
  lib,
  user,
  scheme ? "small",
  colorTheme ? "tokyonight",
  wm ? "",
  homeDirectory ? "",
  ...
}:
with builtins;
{
  options = {
    dotfilesActivation = lib.mkEnableOption "Activate dotfiles";
  };
  imports =
    let
      removeFlavor = head (split "-" colorTheme);
    in
    lib.optionals (scheme != "none") (
      lib.optional (pathExists ../../apps/user/color-theme/${removeFlavor}) ../../apps/user/color-theme/${removeFlavor}
      ++ [
        ../../settings/user/nix
        ../../apps/user/core/bash
        ../../apps/user/core/btop
        ../../apps/user/core/fzf
        ../../apps/user/core/git
        ../../apps/user/core/man
        ../../apps/user/core/pkgs
        ../../apps/user/core/programs
        ../../apps/user/core/yazi
        ../../apps/user/core/sops
        ../../apps/user/core/ssh
        ../../apps/user/core/starship
        ../../apps/user/core/tmux
        ../../apps/user/core/wezterm
        ../../apps/user/core/xdg
      ]
      ++ lib.optionals (scheme != "core") [
        ../../apps/user/small/direnv
        ../../apps/user/small/editorconfig
        ../../apps/user/small/fastfetch
        ../../apps/user/small/lazygit
        ../../apps/user/small/navi
        ../../apps/user/small/neovim
        ../../apps/user/small/pkgs
        ../../apps/user/small/translate-shell
        ../../apps/user/small/zsh
      ]
      ++ lib.optionals (scheme == "medium" || scheme == "full") [
        ../../apps/user/medium/pkgs
        ../../apps/user/medium/texlive
      ]
      ++ lib.optionals (scheme == "full") (
        [ ../../apps/user/full/pkgs ]
        ++ concatMap import [
          ../../apps/user/full/ime
          ../../apps/user/full/programs
          ../../apps/user/full/services
          ../../apps/user/full/systemd
          ../../apps/user/full/terminal
          ../../apps/user/full/theme
          ../../apps/user/full/xdg-mime
        ]
      )
      ++ lib.optionals (wm != "" && pathExists ../../apps/user/full/wm/${wm}) [
        ../../apps/user/full/xsession
        ../../apps/user/full/wm/${wm}
      ]
    );
  config = lib.mkIf config.dotfilesActivation {
    programs.home-manager.enable = true;
    assertions = [
      {
        assertion =
          scheme == "none" || scheme == "core" || scheme == "small" || scheme == "medium" || scheme == "full";
        message = ''
          Set scheme `none` or 'core' or 'small' or 'full'.
          none: not use home-manager config
          core: shell=bash, core utils, no editor, assuming diskless server
          small: shell=zsh, and neovim,
          medium: shell=zsh, daily use such as pandoc and texlive etc.., without GUI apps
          full: shell=zsh, daily use such as neovim and vivaldi, with GUI apps
        '';
      }
    ];
    home = {
      username = "${user}";
      homeDirectory = if homeDirectory == "" then "/home/${user}" else homeDirectory;
    };
    fonts.fontconfig.enable = true;
  };
}
