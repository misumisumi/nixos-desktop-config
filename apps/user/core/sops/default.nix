{ config, ... }:
{
  sops = {
    age = {
      generateKey = true;
      keyFile = "${config.home.homeDirectory}/.age-key.txt";
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
  };
}
