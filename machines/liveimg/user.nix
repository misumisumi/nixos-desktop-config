{
  user,
  pkgs,
  ...
}:
{
  environment.pathsToLink = [ "/share/bash-completion" ];
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
    vteIntegration = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "input"
    ];
    useDefaultShell = true;
    password = "nixos";
  };
  users.users.root.password = "nixos";
}
