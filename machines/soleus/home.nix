{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      wavesurfer # pkgs from Sumi-Sumi/flakes
    ];
  };
  sops.secrets = {
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/pkgs/ssh/univ;
      format = "binary";
    };
  };
}
