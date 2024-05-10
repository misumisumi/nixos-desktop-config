{
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    defaultSopsFile = ../../sops/hosts/zephyrus/secrets.yaml;
    secrets = {
      "openfortivpn/config" = {
        sopsFile = ../../sops/system/openfortivpn/config;
        format = "binary";
      };
      password.neededForUsers = true;
      wireless = {
        sopsFile = ../../sops/system/network/wireless;
        format = "binary";
      };
    };
  };
}
