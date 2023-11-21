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
    # hashedPasswordFile = config.sops.secrets.password.path;
    initialHashedPassword =
      if user == "general"
      then "$6$HhoKyaJgibvjdoPO$swxNlcV6CJTxyKR/I.3o4a1utr2eSLgVjsogNKeo58jY/eFpRciLr8emsCmPxaSa5jwzHnz74RLlXEEYXIoQq/" # general
      else "$6$viPBN7o74kK3JdGw$4zKIuVEbgqvTqLIae/G5rOgrYXWSccB5MQp9/0HgeitQIocLg2.GeG7TWYYfNhZdgs4FNHJuPg5SqSrrIkpr51";
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
