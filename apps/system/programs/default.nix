{ user, ... }:
{
  users = {
    groups.plugdev = { };
    users.${user}.extraGroups = [ "adbusers" "plugdev" ];
  };
  programs = {
    dconf.enable = true;
    udevil.enable = true;
    adb.enable = true;
  };
}
