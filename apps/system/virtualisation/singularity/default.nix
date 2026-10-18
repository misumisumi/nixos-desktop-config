{ pkgs, ... }:
{
  programs.singularity = {
    enable = true;
    enableFakeroot = true;
    package = pkgs.apptainer;
    systemBinPaths = with pkgs; [
      gocryptfs
    ];
  };
}
