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
    stateVersion = stateVersion;
    username = "${user}";
    homeDirectory = "/home/${user}";

    pointerCursor = {                         # This will set cursor systemwide so applications can not choose their own
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
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
      tp = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
      tty-clock = "tty-clock -s -c -C 6";
    };

  };

  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      templates = null;
      publicShare = null;
      extraConfig = {
        XDG_GAME_DIR = "${config.home.homeDirectory}/Game";
        XDG_BIN_DIR = "${config.home.homeDirectory}/bin";
        XDG_3DMODELS_DIR = "${config.home.homeDirectory}/3dModels";
        XDG_WORK_DIR = "${config.home.homeDirectory}/workspace";
      };
    };
  };

}
