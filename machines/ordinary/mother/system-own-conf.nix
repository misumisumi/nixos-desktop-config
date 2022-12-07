{ pkgs, user, ... }:
{
  security.sudo = {
    extraRules = [
      {
        runAs = "${user}";
        commands = [ 
          { 
            command = "${pkgs.xp-pen-driver}/bin/xp-pen-driver"; 
            options = [ "NOPASSWD" ];
          } 
        ];
      }
    ];
  };
}
