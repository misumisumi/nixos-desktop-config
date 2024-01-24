{ config, ... }:
{
  users.mutableUsers = false;
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
    };
    defaultSopsFile = ../../sops/secrets/hosts/soleus/secrets.yaml;
    secrets = {
      password.neededForUsers = true;
      "auto.splab" = {
        sopsFile = ../../sops/secrets/hosts/soleus/auto.splab;
        format = "binary";
      };
    };
  };
}
