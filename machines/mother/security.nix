{ pkgs, user, ... }:
{
  security.sudo = {
    extraRules = [
      {
        users = [ "${user}" ];
        commands = [
          {
            command = "${pkgs.xp-pen-driver}/opt/xp-pen-driver";
            options = [ "SETENV" "NOPASSWD" ];
          }
        ];
      }
    ];
  };

}
