{
  lib,
  user,
  pkgs,
  ...
}:
{
  environment.pathsToLink = [ "/share/bash-completion" ];
  programs.bash = {
    completion.enable = true;
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
    initialHashedPassword = lib.mkForce "$y$j9T$VM2hWCk7A3S5QKFhO1STx1$2Pq/o43bzXFMnpKtxiZiaFZnMuMym3EgqgysBk8sgA/";
  };
  users.users.root.initialHashedPassword = lib.mkForce "$y$j9T$VM2hWCk7A3S5QKFhO1STx1$2Pq/o43bzXFMnpKtxiZiaFZnMuMym3EgqgysBk8sgA/";
}
