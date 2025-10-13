{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  environment = {
    systemPackages = with pkgs; [
      # Yubico's official tools
      yubico-piv-tool
      yubikey-manager
      yubioath-flutter
    ];
  };
}
