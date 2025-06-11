{ pkgs, ... }:
{
  console = {
    # font = "Lat2-Terminus16";
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    useXkbConfig = true;
  };
}
