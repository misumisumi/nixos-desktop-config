{ config, ... }:
{
  systemd.user.startServices = "sd-switch";
  sops = {
    age = {
      generateKey = true;
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
    secrets."ssh.lua" = {
      path = "${config.xdg.configHome}/wezterm/ssh.lua";
      sopsFile = ../../sops/pkgs/wezterm/ssh.lua;
      format = "binary";
    };
  };
}
