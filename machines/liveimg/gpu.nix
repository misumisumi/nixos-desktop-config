{
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nouveau"
        "qxl"
        "modesetting"
        "fbdev"
      ];
    };
  };
}
