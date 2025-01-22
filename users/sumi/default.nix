{ config, pkgs, ... }:
{
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
      keyFile = "${config.home.homeDirectory}/.age-key.txt";
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
    secrets = {
      "ssh.lua" = {
        path = "${config.xdg.configHome}/wezterm/ssh.lua";
        sopsFile = ../../sops/pkgs/wezterm/ssh.lua;
        format = "binary";
      };
      "aichat/config.yaml" = {
        path = "${config.xdg.configHome}/aichat/config.yaml";
        sopsFile = ../../sops/pkgs/aichat/config.yaml;
        format = "binary";
      };
    };
  };
}
