{
  config,
  lib,
  user,
  scheme ? "small",
  colorTheme ? "tokyonight",
  wm ? "none",
  homeDirectory ? "",
  excludeShells ? [ ],
  ...
}:
with builtins;
let
  removeFlavor = head (split "-" colorTheme);
in
{
  options = {
    dotfilesActivation = lib.mkEnableOption "Activate dotfiles";
  };
  imports =
    lib.optional (colorTheme != "") ../../apps/user/color-theme/${removeFlavor}
    ++ (map (x: ../../apps/user/core/${x}) (
      filter (x: !elem x excludeShells) [
        "bash"
        "zsh"
      ]
    ))
    ++ [
      ../../settings/user
      ../../apps/user/core/btop
      ../../apps/user/core/fzf
      ../../apps/user/core/git
      ../../apps/user/core/man
      ../../apps/user/core/pkgs
      ../../apps/user/core/programs
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
      ../../apps/user/small/yazi
      ../../apps/user/small/zoxide
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
        ../../apps/user/full/xdg
      ]
    )
    ++ lib.optionals (wm != "" && wm != "gnome") [
      ../../apps/user/full/xsession
      ../../apps/user/full/wm
      ../../apps/user/full/wm/${wm}
    ];
  config = lib.mkIf config.dotfilesActivation {
    programs.home-manager.enable = true;
    assertions =
      [
        {
          assertion = pathExists ../../apps/user/${scheme};
          message = ''
            Set scheme 'core' or 'small' or 'medium' or 'full'.
            core: minimal environment. assumed to be used on a serve
            small: an environment containing neovim and useful apps. assumed to be used on an organization's server.
            medium: small + texlive and pandoc.
            full: a desktop environment. mainly intended for use with NixOS
          '';
        }
        {
          assertion = pathExists ../../apps/user/color-theme/${removeFlavor};
          message = ''
            `${removeFlavor}` is not supported color theme.
            See supported color theme list in apps/user/color-theme.
          '';
        }
        {
          assertion = wm != "";
          message = ''
            wm must be set to 'none' or 'gnome' or wm name in apps/user/full/wm/.
          '';
        }
      ]
      ++ lib.optionals (wm != "none" && wm != "gnome" && scheme == "full") [
        {
          assertion = pathExists ../../apps/user/full/wm/${wm};
          message = ''
            `${wm}` is not supported window-manager.
            See supported window-manager list in apps/user/full/wm.
            XMonad is not supported now.
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
