{ pkgs, ... }:
{
  console = {
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    useXkbConfig = true;
  };
}
