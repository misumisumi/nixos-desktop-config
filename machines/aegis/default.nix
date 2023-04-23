{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    "sslh.conf".text = ''
      test
    '';
  };
}
