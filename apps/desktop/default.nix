{ lib, hostname, isFull ? false, ... }:
with lib;
(
  (import ./ime) ++
  (import ./systemd) ++
  (import ./wm/common) ++
  optionals isFull (
    (import ./games) ++
    (import ./programs) ++
    (import ./services) ++
    (import ./terminal) ++
    (import ./theme) ++
    (import ./xdg-mime)
  )
)
