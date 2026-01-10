{ user, ... }:
{
  users = {
    groups.plugdev = { };
    users.${user}.extraGroups = [
      "plugdev"
    ];
  };
  programs = {
    dconf.enable = true;
    udevil.enable = true;
  };
}
