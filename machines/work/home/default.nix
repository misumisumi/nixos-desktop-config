{
  pkgs,
  config,
  ...
}:
{
  sops.secrets = {
    "work" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/work";
      sopsFile = ../../../sops/pkgs/ssh/work;
      format = "binary";
    };
  };
  home.packages = with pkgs; [
    audacity
    firefox
    mpv
  ];
}
