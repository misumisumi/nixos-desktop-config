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
  imports =                                   # Home Manager Modules
    (import ../apps/ide) ++
    (import ../apps/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";


    pointerCursor = {                         # This will set cursor systemwide so applications can not choose their own
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };

    sessionVariables = {
      CHROME_PATH="${pkgs.vivaldi}/bin/vivaldi";
      EDITOR=nvim;
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

    stateVersion = "stateVersion";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
    };                                        # Cursor is declared under home.pointerCursor
  };
}
