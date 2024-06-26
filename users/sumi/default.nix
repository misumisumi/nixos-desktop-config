{ config, ... }:
{
  systemd.user.startServices = "sd-switch";
  sops = {
    age = {
      # keyFile = "${config.home.homeDirectory}/.age-key.txt";
      # sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sshKeyPaths = [ ];
    };
    secrets = {
      "ssh.lua" = {
        path = "${config.xdg.configHome}/wezterm/ssh.lua";
        sopsFile = ../../sops/user/wezterm/ssh.lua;
        format = "binary";
      };
      "aichat/config.yaml" = {
        path = "${config.xdg.configHome}/aichat/config.yaml";
        sopsFile = ../../sops/user/aichat/config.yaml;
        format = "binary";
      };
    };
  };
}
