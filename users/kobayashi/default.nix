{ config, ... }:
{
  systemd.user.startServices = "sd-switch";
  sops = {
    secrets."ssh.lua" = {
      path = "${config.xdg.configHome}/wezterm/ssh.lua";
      sopsFile = ../../sops/user/wezterm/ssh.lua;
      format = "binary";
    };
  };
}
