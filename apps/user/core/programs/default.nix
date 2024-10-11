{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ trash-cli ];
    shellAliases = {
      tm = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
    };
  };
  programs = {
    dircolors.enable = true;
    jq.enable = true;
  };
}
