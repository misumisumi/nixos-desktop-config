{ lib
, hostname
, isMidium ? false
, isLarge ? false
, ...
}:
with lib; (
  (import ./ime)
  ++ (import ./wm/common)
  ++ optionals (isMidium || isLarge) (
    (import ./programs)
    ++ (import ./services)
    ++ (import ./systemd)
    ++ (import ./terminal)
    ++ (import ./theme)
    ++ (import ./xdg-mime)
  )
  ++ optionals isLarge (import ./game)
)
