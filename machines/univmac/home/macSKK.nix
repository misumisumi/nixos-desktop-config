{
  lib,
  pkgs,
  ...
}:
{
  home = {
    activation.setMacSKKConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rsync}/bin/rsync --chmod=600 ${./net.mtgto.inputmethod.macSKK.plist} $HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Library/Preferences/net.mtgto.inputmethod.macSKK.plist
      ${pkgs.rsync}/bin/rsync --chmod=644 ${pkgs.yaskkserv2-dict}/share/SKK-JISYO.yaskkserv2.utf8 $HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/SKK-JISYO.yaskkserv2.utf8
    '';
  };
}
