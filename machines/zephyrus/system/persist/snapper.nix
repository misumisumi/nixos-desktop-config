{
  services.snapper = {
    snapshotInterval = "hourly";
    snapshotRootOnBoot = false;
    persistentTimer = true;
    configs = {
      system = {
        SUBVOLUME = "/nix/persist";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_YEARLY = 0;
        TIMELINE_LIMIT_WEEKLY = 0;
        TIMELINE_LIMIT_MONTHLY = 0;
        TIMELINE_LIMIT_DAILY = 7;
        TIMELINE_LIMIT_HOURLY = 5;
      };
      home = {
        SUBVOLUME = "/nix/persist/home";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_YEARLY = 0;
        TIMELINE_LIMIT_WEEKLY = 0;
        TIMELINE_LIMIT_MONTHLY = 0;
        TIMELINE_LIMIT_DAILY = 7;
        TIMELINE_LIMIT_HOURLY = 5;
      };
    };
  };
}
