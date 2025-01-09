{ pkgs, ... }:
{
  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
  environment.systemPackages = with pkgs; [
    # Yubico's official tools
    yubikey-manager
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
    yubioath-flutter
  ];
}
