{ config, ... }:
{
  sops = {
    age.generateKey = true;
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
  };
}
