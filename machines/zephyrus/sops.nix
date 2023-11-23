{ config, ... }:
{
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    defaultSopsFile = ../../sops/secrets/hosts/zephyrus/secrets.yaml;
    secrets = {
      "openfortivpn/config" = {
        sopsFile = ../../sops/secrets/openfortivpn/config;
        format = "binary";
      };
      password.neededForUsers = true;
      wireless = {
        sopsFile = ../../sops/secrets/network/wireless;
        format = "binary";
      };
    };
  };
}
