{
  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
    };
    defaultSopsFile = ../../sops/hosts/stacia/secrets.yaml;
    secrets = {
      hashedPassword.neededForUsers = true;
    };
  };
}
