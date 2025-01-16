{ config, pkgs, ... }:
{
  services = {
    pcscd = {
      enable = true;
      extraArgs = [
        "-c"
        "/etc/reader.conf.d"
      ];
    };
    udev.packages = [ pkgs.yubikey-personalization ];
  };
  environment = {
    etc."reader.conf".enable = false;
    etc."reader.conf.d".source =
      let
        configsEnv = pkgs.stdenvNoCC.mkDerivation {
          name = "pcscd-configs";
          buildInputs = config.services.pcscd.plugins;
          dontUnpack = true;
          dontBuild = true;
          installPhase = ''
            mkdir -p $out
            for plugin in $buildInputs; do
              if [ -d $plugin/etc/reader.conf.d ]; then
                cp -v $plugin/etc/reader.conf.d/* $out
              fi
            done

          '';
        };
      in
      configsEnv;
    systemPackages = with pkgs; [
      # Yubico's official tools
      yubikey-manager
      yubikey-personalization
      yubikey-personalization-gui
      yubico-piv-tool
      yubioath-flutter
    ];
  };
}
