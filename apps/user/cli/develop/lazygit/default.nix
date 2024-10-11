{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        };
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
