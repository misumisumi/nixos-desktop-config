{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pager = "${pkgs.delta}/bin/delta --paging=never";
      };
      gui = {
        theme = {
          selectedLineBgColor = [ "default" ];
          selectedRangeBgColor = [ "default" ];
        };
      };
      refresher = {
        refreshInterval = 3;
      };
      os = {
        editCommand = "nvim";
      };
    };
  };
}
