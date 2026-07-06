{ config, ... }:
{
  programs.rclone = {
    enable = true;
    remotes = {
      gdrive = {
        config = {
          type = "drive";
          scope = "drive";
          team_drive = "";
          service_account_file = config.sops.secrets."rclone/gdrive/service_account_file".path;
        };
        secrets = {
          impersonate = config.sops.secrets."rclone/gdrive/impersonate".path;
        };
        mounts = {
          "rclone" = {
            enable = true;
            mountPoint = "${config.xdg.userDirs.publicShare}/gdrive";
          };
          "zotero" = {
            enable = true;
            mountPoint = "${config.xdg.userDirs.publicShare}/zotero";
          };
        };
      };
    };
  };
}
