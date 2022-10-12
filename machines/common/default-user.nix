# Default normal user config

{ pkgs, user, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    initialHashedPassword = "$6$viPBN7o74kK3JdGw$4zKIuVEbgqvTqLIae/G5rOgrYXWSccB5MQp9/0HgeitQIocLg2.GeG7TWYYfNhZdgs4FNHJuPg5SqSrrIkpr51";
    extraGroups = [ "wheel" "lxd" "libvirt" "uucp" "kvm" "input" ];
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
