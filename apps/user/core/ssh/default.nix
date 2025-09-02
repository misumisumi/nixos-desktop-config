{
  config,
  lib,
  hostname,
  pkgs,
  ...
}:
{
  home.activation.sshActivatioinAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f ${config.home.homeDirectory}/.ssh/id_ed25519.pub ]; then
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -C "$(whoami)@${hostname}-$(date -I)" -f ${config.home.homeDirectory}/.ssh/id_ed25519
    fi
    # if [ ! -f ${config.home.homeDirectory}/.ssh/id_rsa.pub ]; then
    #   ${pkgs.openssh}/bin/ssh-keygen -t rsa -b 4096 -N "" -C "$(whoami)@${hostname}-$(date -I)" -f ${config.home.homeDirectory}/.ssh/id_rsa
    # fi
  '';
  programs.ssh = {
    enable = true;
    includes = [ "conf.d/hosts/*" ];
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
        serverAliveInterval = 30;
        serverAliveCountMax = 5;
      };
      "github" = {
        user = "git";
        hostname = "github.com";
      };
      "github.com" = {
        user = "git";
        hostname = "ssh.github.com";
        port = 443;
      };
    };
  };
}
