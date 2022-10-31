# Default normal user config

{ pkgs, user, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.${user} = {
    isNormalUser = true;
    home="/home/${user}";
    createHome = true;
    shell = pkgs.zsh;
    initialHashedPassword = if user == "general"
      then "$6$HhoKyaJgibvjdoPO$swxNlcV6CJTxyKR/I.3o4a1utr2eSLgVjsogNKeo58jY/eFpRciLr8emsCmPxaSa5jwzHnz74RLlXEEYXIoQq/" # general
      else "$6$viPBN7o74kK3JdGw$4zKIuVEbgqvTqLIae/G5rOgrYXWSccB5MQp9/0HgeitQIocLg2.GeG7TWYYfNhZdgs4FNHJuPg5SqSrrIkpr51";
    extraGroups = [ "wheel" "lxd" "libvirt" "uucp" "kvm" "input" "audio" "video" "scanner" "lp" ];
    useDefaultShell = true;
    subUidRanges = [             # Using rootless container
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

  security.sudo.wheelNeedsPassword = true; # User does need to give password when using sudo.
}
