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
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
