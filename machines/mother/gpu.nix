{
  services = {
    xserver = {
      videoDrivers = [
        "nvidia"
      ];
    };
  };

  hardware = {
    opengl.extraPackages = with pkgs; [
    ];
  };
}
