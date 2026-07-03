{ config, ... }:
{
  programs.rclone = {
    enable = true;
    remotes = {
      gdrive = {
        config = {
          type = "drive";
          scope = "drive";
        };
        secrets = {
          client_id = config.sops.secrets."rclone/gdrive/client_id".path;
          client_secret = config.sops.secrets."rclone/gdrive/client_secret".path;
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
