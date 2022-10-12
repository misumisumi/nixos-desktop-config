{
  systemd = {
    network = {
      wait-online = {
        timeout = 0;    # Disable wait online
        anyInterface = true;
      };
    };
  };

  services = {
    nscd = {
      enable = false;
    };
    resolved = {
      enable = true;
    };
  };

}
