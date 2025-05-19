{ lib, ... }:
{
  sops = {
    age = {
      sshKeyPaths = [ "/nix/persist/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = lib.mkForce "/nix/persist/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    defaultSopsFile = ../../../sops/hosts/stacia/secrets.yaml;
    secrets = {
      hashedPasswordFile.neededForUsers = true;
    };
  };
}
