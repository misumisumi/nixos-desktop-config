{
  systemd = {
    network = {
      wait-online = {
        timeout = 0;    # Disable wait online
        anyInterface = true;
      };
    };
  };

}
