{ lib, hostname, ... }:
with lib;
(
  (import ./ime) ++
  (import ./media) ++
  (import ./services) ++
  (import ./systemd) ++
  (import ./terminal) ++
  (import ./wm/common) ++
  (import ./xdg-mime) ++
  optionals (hostname != "general") (import ./theme)
)
