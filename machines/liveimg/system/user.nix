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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCGcY4v0aRzAO+hLnGhEaU7JArt/Wrn8FuIgFcovlad sumi@mother-2021-03-12"
    ];
    initialHashedPassword = lib.mkForce "$y$j9T$VM2hWCk7A3S5QKFhO1STx1$2Pq/o43bzXFMnpKtxiZiaFZnMuMym3EgqgysBk8sgA/";
  };
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCGcY4v0aRzAO+hLnGhEaU7JArt/Wrn8FuIgFcovlad sumi@mother-2021-03-12"
    ];
    initialHashedPassword = lib.mkForce "$y$j9T$VM2hWCk7A3S5QKFhO1STx1$2Pq/o43bzXFMnpKtxiZiaFZnMuMym3EgqgysBk8sgA/";
  };
}
