#
#  General Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix *
#   └─ ./apps
#       └─ ./common
#           ├─ ./cui
#           │   └─ default.nix
#           ├─ ./ide
#           │   └─ default.nix
#           └─ ./ide
#               └─ default.nix
#

{ config, lib, pkgs, user, stateVersion, ... }:

{ 
  programs = {
    home-manager.enable = true;
  };

  home = {
    inherit stateVersion;
    username = "${user}";
    homeDirectory = "/home/${user}";
    activation = {
      myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d ${config.home.homeDirectory}/.config/ranger ]; then
          mkdir ${config.home.homeDirectory}/.config/ranger
        fi
        if [[ ! -f ${config.home.homeDirectory}/.zinit/completions/_zinit ]]; then
          mkdir -p ${config.home.homeDirectory}/.zinit/completions/ 
          ln -sf ${config.xdg.configHome}/zsh/plugins/zinit/share/zsh/site-functions/_zinit ''${ZINIT_HOME}/completions/
        fi
      '';
    };


    sessionVariables = {
      CHROME_PATH="${pkgs.vivaldi}/bin/vivaldi";
      EDITOR="nvim";
    };

    shellAliases = {
      ls="ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "grep -F --color=auto";
      egrep = "grep -E --color=auto";
      tm = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
      tty-clock = "tty-clock -s -c -C 6";
    };

  };
  fonts.fontconfig.enable = true;

  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_GAME_DIR = "${config.home.homeDirectory}/Game";
        XDG_BIN_DIR = "${config.home.homeDirectory}/bin";
        XDG_3DMODELS_DIR = "${config.home.homeDirectory}/3dModels";
        XDG_WORK_DIR = "${config.home.homeDirectory}/workspace";
      };
    };
  };

}
