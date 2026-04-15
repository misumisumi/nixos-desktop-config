# light weight skk server
{ lib, config, ... }:
let
  inherit (lib) optional;
in
{
  services.yaskkserv2 = {
    enable = true;
    extraArgs = [
      "--google-japanese-input notfound"
      "--google-cache-filename=/tmp/yaskkserv2.cache"
    ]
    ++ optional (
      config.i18n.inputMethod.enable && config.i18n.inputMethod.type == "fcitx5"
    ) "--midashi-utf8";
  };
}
