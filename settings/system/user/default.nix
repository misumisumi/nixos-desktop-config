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
  users.users.${user} =
    {
      isNormalUser = true;
      shell = pkgs.zsh;
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
    // lib.optionalAttrs (builtins.hasAttr "hashedPassword" config.sops) {
      inherit (config.sops) hashedPassword;
    }
    // lib.optionalAttrs (!builtins.hasAttr "hashedPassword" config.sops) {
      password = "nixos";
    };
  users.users.root =
    lib.optionalAttrs (builtins.hasAttr "hashedPassword" config.sops) {
      inherit (config.sops) hashedPassword;
    }
    // lib.optionalAttrs (!builtins.hasAttr "hashedPassword" config.sops) {
      password = "nixos";
    };
}
