{
  users.mutableUsers = false;
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
    };
    defaultSopsFile = ../../sops/hosts/soleus/secrets.yaml;
    secrets = {
      hashedPassword.neededForUsers = true;
      "auto.splab" = {
        sopsFile = ../../sops/hosts/soleus/auto.splab;
        format = "binary";
      };
    };
  };
}
