{ pkgs, ... }:
{
  home.packages = with pkgs; [
    looking-glass-client # A KVM Frame Relay (KVMFR) implementation
  ];
  xdg.configFile."looking-glass/client.ini" = {
    text = ''
      [audio]
      micDefault=allow
      syncVolume=yes
    '';
  };
}
