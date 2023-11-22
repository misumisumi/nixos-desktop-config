{ config, ... }:
{
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
    };
    defaultSopsFile = ../../sops/secrets/hosts/stacia/secrets.yaml;
    secrets = {
      "password".neededForUsers = true;
    };
  };
}
