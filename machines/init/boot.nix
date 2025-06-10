{
  boot = {
    loader = {
      timeout = 10;
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
