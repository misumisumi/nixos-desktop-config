# ranger (CLI Filer) conf
# ranger need writable conf dir.
# If you want to edit rc.conf (ranger preferences), you muse use nixpkgs override like this.
{ lib, config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [ ranger trash-cli ];
    activation = {
      rangerActivatioinAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d ${config.xdg.configHome}/ranger ]; then
          mkdir ${config.xdg.configHome}/ranger
        fi
      '';
    };
    shellAliases = {
      tm = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
    };
  };
  xdg = {
    configFile = {
      "ranger/rifle.conf".source = ./config/rifle.conf;
      "ranger/rc.conf".source = ./config/rc.conf;
    };
  };
}
