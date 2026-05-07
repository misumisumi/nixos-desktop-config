{
  config,
  pkgs,
  getEncryptFile,
  ...
}:
{
  imports = [
    ./mail
  ];
  systemd.user.startServices = "sd-switch";
  home.packages = with pkgs; [
    sops
  ];
  sops = {
    environment = {
      GNUPGHOME = "~/.dummy"; # disable decryption using pgp key
    };
    age = {
      generateKey = true;
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
    defaultSopsFile = getEncryptFile "users/sumi/secrets.yaml";
    secrets = {
      "bw/personal".mode = "0400";
      "bw/univ".mode = "0400";
      "ssh.lua" = {
        path = "${config.xdg.configHome}/wezterm/ssh.lua";
        sopsFile = getEncryptFile "pkgs/wezterm/ssh.lua";
        format = "binary";
      };
      "id_ed25519.sshserver" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.sshserver";
        sopsFile = getEncryptFile "users/sumi/.ssh/id_ed25519.sshserver";
        format = "binary";
      };
      "id_ed25519.homelab.dev" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.homelab.dev";
        sopsFile = getEncryptFile "users/sumi/.ssh/id_ed25519.homelab.dev";
        format = "binary";
      };
      "id_ed25519.homelab.dev.pub" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.homelab.dev.pub";
        sopsFile = getEncryptFile "users/sumi/.ssh/id_ed25519.homelab.dev.pub";
        format = "binary";
      };
      "id_ed25519.homelab" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.homelab";
        sopsFile = getEncryptFile "users/sumi/.ssh/id_ed25519.homelab";
        format = "binary";
      };
      "id_ed25519.homelab.pub" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.homelab.pub";
        sopsFile = getEncryptFile "users/sumi/.ssh/id_ed25519.homelab.pub";
        format = "binary";
      };
      "aichat/config.yaml" = {
        path = "${config.xdg.configHome}/aichat/config.yaml";
        sopsFile = getEncryptFile "pkgs/ai-tools/config.yaml.txt";
        format = "binary";
      };
    };
  };
}
