{ lib, hostname, isFull ? false, ... }:
with lib;
(
  (import ./ime) ++
  (import ./programs) ++
  (import ./systemd) ++
  (import ./terminal) ++
  (import ./wm/common) ++
  optionals isFull (
    (import ./games) ++
    (import ./services) ++
    (import ./theme) ++
    (import ./xdg-mime)
  )
)
