# Default normal user config
{ config
, hostname
, user
, pkgs
, ...
}: {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [ "wheel" "uucp" "kvm" "input" "audio" "video" "scanner" "lp" "lxd" ];
    useDefaultShell = true;
    subUidRanges = [
      # Using rootless container
      {
        count = 100000;
        startUid = 300000;
      }
    ];
    subGidRanges = [
      {
        count = 100000;
        startGid = 300000;
      }
    ];
  };
}
