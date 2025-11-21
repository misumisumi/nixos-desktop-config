{ config, pkgs, ... }:
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
    secrets = {
      "ssh.lua" = {
        path = "${config.xdg.configHome}/wezterm/ssh.lua";
        sopsFile = ../../sops/pkgs/wezterm/ssh.lua;
        format = "binary";
      };
      "aichat/config.yaml" = {
        path = "${config.xdg.configHome}/aichat/config.yaml";
        sopsFile = ../../sops/pkgs/ai-tools/config.yaml.txt;
        format = "binary";
      };
    };
  };
}
