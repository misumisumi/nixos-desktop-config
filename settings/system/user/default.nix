# Default normal user config
{
  config,
  lib,
  user,
  pkgs,
  ...
}:
{
  environment.pathsToLink = [
    "/share/zsh"
    "/share/bash-completion"
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCGcY4v0aRzAO+hLnGhEaU7JArt/Wrn8FuIgFcovlad sumi@mother-2021-03-12"
    ];
    extraGroups = [
      "input"
      "uinput"
      "uucp"
      "wheel"
    ];
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
  }
  // lib.optionalAttrs (builtins.hasAttr "hashedPasswordFile" config.sops.secrets) {
    hashedPasswordFile = config.sops.secrets.hashedPasswordFile.path;
  };
  users.users.root = lib.optionalAttrs (builtins.hasAttr "hashedPasswordFile" config.sops.secrets) {
    hashedPasswordFile = config.sops.secrets.hashedPasswordFile.path;
  };
}
