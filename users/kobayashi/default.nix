{ config, getEncryptFile, ... }:
{
  systemd.user.startServices = "sd-switch";
  sops = {
    age = {
      generateKey = true;
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
    defaultSopsFile = getEncryptFile "users/sumi/secrets.yaml";
    secrets = {
      "bw/personal".mode = "0400";
      "bw/univ".mode = "0400";
    };
  };
}
