{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../apps/user/full/programs/firefox.nix
    ../../apps/user/full/programs/vivaldi.nix
  ] ++ (import ../../apps/user/full/ime);
  home = {
    packages = with pkgs; [
      ffmpeg # Multi media solution
      graphicsmagick # CLI Image Editor
      nomacs # Image Viewer
      sox # CLI Sound Editor
      wavesurfer # pkgs from Sumi-Sumi/flakes
    ];
  };
  sops.secrets = {
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/user/ssh/univ;
      format = "binary";
    };
  };
}
